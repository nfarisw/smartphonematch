<?php
// GET /smartphone.php?slug=redmi-note-13&market=ES|US
require __DIR__ . '/config.php';
require __DIR__ . '/../lang/i18n.php';
json_headers();

$slug = $_GET['slug'] ?? '';
if ($slug === '') send_json(['error' => 'missing_slug'], 400);
$market = in_array($_GET['market'] ?? '', SPM_MARKETS, true) ? $_GET['market'] : resolve_market(resolve_lang());

try {
    $stmt = db()->prepare(
        "SELECT s.*, b.name AS brand_name, b.slug AS brand_slug
         FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.slug = :slug AND s.active = 1"
    );
    $stmt->execute([':slug' => $slug]);
    $phone = $stmt->fetch();
    if (!$phone) send_json(['error' => 'not_found'], 404);

    // Solo retailers del mercado solicitado — así una ficha en inglés/US
    // nunca enseña PcComponentes/MediaMarkt, ni una en español enseña
    // Best Buy/Walmart.
    $links = db()->prepare(
        "SELECT p.condition, p.refurb_grade, p.url, p.availability, r.name AS retailer_name, r.slug AS retailer_slug
         FROM prices p JOIN retailers r ON r.id = p.retailer_id
         WHERE p.smartphone_id = :id AND r.market = :market ORDER BY p.condition, r.name"
    );
    $links->execute([':id' => $phone['id'], ':market' => $market]);
    $offers = $links->fetchAll();
    foreach ($offers as &$offer) {
        $offer['url'] = apply_amazon_tag($offer['url'], $market);
    }
    unset($offer);
    $phone['offers'] = $offers;
    $phone['market'] = $market;

    send_json($phone);
} catch (Throwable $e) {
    send_error($e);
}
