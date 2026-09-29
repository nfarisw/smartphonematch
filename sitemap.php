<?php
/**
 * Sitemap generado desde la base de datos — cada vez que se añade o
 * quita un móvil del catálogo, el sitemap se actualiza solo, sin tocar
 * este archivo. Incluye ambos idiomas para cada URL, con hreflang
 * cruzado (xhtml:link) para que los buscadores sepan que son la misma
 * página en dos idiomas y no contenido duplicado.
 */
require __DIR__ . '/smartphonematch-api/config.php';
require __DIR__ . '/lang/i18n.php';
header('Content-Type: application/xml; charset=utf-8');

[$scheme, $host] = current_scheme_host();
$base = "$scheme://$host";

// $type/$params generan la entrada para AMBOS idiomas de una sola vez, con
// los <xhtml:link hreflang> cruzados entre sí.
function sitemap_entry(string $type, array $params, string $priority, ?string $lastmod = null): array {
    $urls = [];
    foreach (SPM_LANGS as $lang) {
        $urls[] = [
            'loc' => url_for($lang, $type, $params),
            'priority' => $priority,
            'lastmod' => $lastmod,
            'alternates' => alternate_urls($type, $params),
        ];
    }
    return $urls;
}

$entries = [];
foreach (sitemap_entry('home', [], '1.0') as $u) $entries[] = $u;
foreach (sitemap_entry('deals', [], '0.9') as $u) $entries[] = $u;
foreach (sitemap_entry('about', [], '0.3') as $u) $entries[] = $u;
foreach (sitemap_entry('privacy', [], '0.3') as $u) $entries[] = $u;
foreach (sitemap_entry('legal', [], '0.3') as $u) $entries[] = $u;
foreach (sitemap_entry('cookies', [], '0.3') as $u) $entries[] = $u;

try {
    $stmt = db()->query("SELECT slug, updated_at FROM smartphones WHERE active = 1 ORDER BY slug");
    foreach ($stmt->fetchAll() as $row) {
        $lastmod = date('Y-m-d', strtotime($row['updated_at'] ?? 'now'));
        foreach (sitemap_entry('mobile', ['slug' => $row['slug']], '0.8', $lastmod) as $u) $entries[] = $u;
    }

    // Páginas de marca — una por marca con al menos un móvil activo.
    $brandStmt = db()->query(
        "SELECT b.slug FROM brands b WHERE EXISTS (SELECT 1 FROM smartphones s WHERE s.brand_id = b.id AND s.active = 1)"
    );
    foreach ($brandStmt->fetchAll() as $row) {
        foreach (sitemap_entry('brand', ['slug' => $row['slug']], '0.6') as $u) $entries[] = $u;
    }

    // Páginas de presupuesto — solo las que de verdad tienen varios móviles
    // que cumplan (nada de indexar una página vacía o con 1 resultado).
    $budgetStmt = db()->prepare("SELECT COUNT(*) c FROM smartphones WHERE active = 1 AND price_min <= :max");
    foreach ([200, 300, 500, 800, 1000] as $max) {
        $budgetStmt->execute([':max' => $max]);
        if ((int)$budgetStmt->fetch()['c'] >= 3) {
            foreach (sitemap_entry('budget', ['max' => $max], '0.7') as $u) $entries[] = $u;
        }
    }
} catch (Throwable $e) {
    error_log($e->getMessage());
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">' . "\n";
foreach ($entries as $u) {
    echo "  <url>\n";
    echo "    <loc>" . htmlspecialchars($base . $u['loc'], ENT_XML1) . "</loc>\n";
    if ($u['lastmod']) echo "    <lastmod>{$u['lastmod']}</lastmod>\n";
    echo "    <priority>{$u['priority']}</priority>\n";
    foreach ($u['alternates'] as $altLang => $altPath) {
        echo '    <xhtml:link rel="alternate" hreflang="' . $altLang . '" href="' . htmlspecialchars($base . $altPath, ENT_XML1) . "\" />\n";
    }
    echo "  </url>\n";
}
echo '</urlset>';
