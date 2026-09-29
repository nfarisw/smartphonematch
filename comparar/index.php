<?php
/**
 * /{lang}/comparar|compare/{slug-a}-vs-{slug-b} — comparativa indexable de
 * dos móviles. Misma base de datos que el resto del sitio; el análisis de
 * "cuál encaja mejor" se genera a partir de las diferencias reales de
 * puntuación/precio, no de un texto fijo.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';

$lang = resolve_lang();
$market = resolve_market($lang);

function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
$eur = fn($min, $max) => fmt_price($market, $min, $max);

$slugA = preg_replace('/[^a-z0-9-]/', '', $_GET['a'] ?? '');
$slugB = preg_replace('/[^a-z0-9-]/', '', $_GET['b'] ?? '');
if (!$slugA || !$slugB || $slugA === $slugB) { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }

try {
    $stmt = db()->prepare(
        "SELECT s.*, b.name AS brand_name FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.slug IN (:a, :b) AND s.active = 1"
    );
    $stmt->execute([':a' => $slugA, ':b' => $slugB]);
    $rows = $stmt->fetchAll();
    $byslug = [];
    foreach ($rows as $r) $byslug[$r['slug']] = $r;
    if (!isset($byslug[$slugA]) || !isset($byslug[$slugB])) { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }
    $a = $byslug[$slugA]; $b = $byslug[$slugB];
} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    echo "Server error.";
    exit;
}

[$scheme, $host] = current_scheme_host();
$nameA = "{$a['brand_name']} {$a['model']}"; $nameB = "{$b['brand_name']} {$b['model']}";
$title = t('compare.title', $lang, ['nameA' => $nameA, 'nameB' => $nameB]) . " — SmartPhoneMatch";
$description = t('compare.description', $lang, ['nameA' => $nameA, 'nameB' => $nameB]);

$rowsSpec = [
  [t('compare.spec.price', $lang), fn($p) => "~" . $eur($p['price_min'], $p['price_max']), fn($p) => (float)$p['price_min'], 'min'],
  [t('compare.spec.screen', $lang), fn($p) => $p['screen_size']],
  [t('compare.spec.refresh', $lang), fn($p) => $p['refresh_rate']],
  [t('compare.spec.cpu', $lang), fn($p) => $p['processor']],
  [t('compare.spec.ram', $lang), fn($p) => $p['ram']],
  [t('compare.spec.storage', $lang), fn($p) => $p['storage']],
  [t('compare.spec.battery', $lang), fn($p) => $p['battery_mah']],
  [t('compare.spec.fast_charging', $lang), fn($p) => $p['fast_charging']],
  [t('compare.spec.main_camera', $lang), fn($p) => $p['main_camera']],
  [t('compare.spec.weight', $lang), fn($p) => $p['weight']],
  [t('compare.spec.water', $lang), fn($p) => $p['water_resistance']],
  [t('compare.spec.updates', $lang), fn($p) => $p['update_years'], fn($p) => (int)$p['update_years'], 'max'],
  [t('compare.spec.score_camera', $lang), fn($p) => $p['photo_score'] . '/100', fn($p) => (int)$p['photo_score'], 'max'],
  [t('compare.spec.score_performance', $lang), fn($p) => $p['performance_score'] . '/100', fn($p) => (int)$p['performance_score'], 'max'],
  [t('compare.spec.score_battery', $lang), fn($p) => $p['battery_score'] . '/100', fn($p) => (int)$p['battery_score'], 'max'],
  [t('compare.spec.score_value', $lang), fn($p) => $p['value_score'] . '/100', fn($p) => (int)$p['value_score'], 'max'],
  [t('compare.spec.5g', $lang), fn($p) => $p['has_5g'] ? t('spec.yes', $lang) : t('spec.no', $lang)],
  [t('compare.spec.esim', $lang), fn($p) => $p['has_esim'] ? t('spec.yes', $lang) : t('spec.no', $lang)],
];

// "¿Cuál encaja mejor?" — solo se generan frases cuando la diferencia es
// real y notable; si están muy igualados, no se inventa un motivo.
$fit = [];
$scoreDims = [
  'photo_score' => t('compare.dim_camera', $lang), 'battery_score' => t('compare.dim_battery', $lang),
  'gaming_score' => t('compare.dim_gaming', $lang), 'performance_score' => t('compare.dim_performance', $lang),
];
foreach ($scoreDims as $field => $label) {
    $diff = (int)$a[$field] - (int)$b[$field];
    if (abs($diff) >= 8) {
        $winner = $diff > 0 ? $nameA : $nameB;
        $fit[] = t('compare.fit_priority', $lang, ['dimension' => $label, 'winner' => $winner, 'hi' => max($a[$field], $b[$field]), 'lo' => min($a[$field], $b[$field])]);
    }
}
$priceDiff = (float)$a['price_min'] - (float)$b['price_min'];
if (abs($priceDiff) >= 30) {
    $cheaper = $priceDiff > 0 ? $nameB : $nameA;
    $fit[] = t('compare.fit_budget', $lang, ['winner' => $cheaper, 'diff' => number_format(abs($priceDiff), 0, ',', '.')]);
}

$breadcrumbSchema = [
  "@context" => "https://schema.org", "@type" => "BreadcrumbList",
  "itemListElement" => [
    ["@type" => "ListItem", "position" => 1, "name" => "SmartPhoneMatch", "item" => "$scheme://$host" . url_for($lang, 'home')],
    ["@type" => "ListItem", "position" => 2, "name" => t('compare.breadcrumb', $lang), "item" => "$scheme://$host" . url_for($lang, 'deals')],
    ["@type" => "ListItem", "position" => 3, "name" => "$nameA vs $nameB", "item" => "$scheme://$host" . url_for($lang, 'compare', ['a' => $a['slug'], 'b' => $b['slug']])],
  ],
];
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e($description) ?>">
<?php render_hreflang($lang, 'compare', ['a' => $a['slug'], 'b' => $b['slug']]); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<meta property="og:description" content="<?= e($description) ?>">
<?php render_head_common(); ?>
<script type="application/ld+json"><?= json_encode($breadcrumbSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
</head>
<body>
<?php render_chrome_open($lang, 'compare'); ?>

<main>
<nav class="breadcrumbs" aria-label="Breadcrumb">
  <a href="<?= e(url_for($lang, 'home')) ?>">SmartPhoneMatch</a><span class="sep">/</span><span><?= e(t('compare.breadcrumb', $lang)) ?></span><span class="sep">/</span><span><?= e($nameA) ?> vs <?= e($nameB) ?></span>
</nav>

<section class="view" style="padding:36px 0 10px;">
  <div class="eyebrow"><?= e(t('compare.eyebrow', $lang)) ?></div>
  <h1 style="font-size:28px;"><?= e($nameA) ?> vs <?= e($nameB) ?></h1>

  <table class="cmp">
    <thead><tr><th><?= e(t('compare.col_feature', $lang)) ?></th><th><?= e($nameA) ?></th><th><?= e($nameB) ?></th></tr></thead>
    <tbody>
      <?php foreach ($rowsSpec as $row): $label = $row[0]; $get = $row[1]; $cmp = $row[2] ?? null; $mode = $row[3] ?? null;
        $winIdx = -1;
        if ($cmp) { $va = $cmp($a); $vb = $cmp($b); if ($va != $vb) $winIdx = ($mode === 'min') ? ($va < $vb ? 0 : 1) : ($va > $vb ? 0 : 1); } ?>
      <tr>
        <td class="spec-label"><?= e($label) ?></td>
        <td class="<?= $winIdx === 0 ? 'win' : '' ?>"><?= e($get($a)) ?></td>
        <td class="<?= $winIdx === 1 ? 'win' : '' ?>"><?= e($get($b)) ?></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>

  <div class="section-head"><h2 style="font-size:20px;"><?= e(t('compare.fit_heading', $lang)) ?></h2></div>
  <?php if ($fit): ?>
    <?php foreach ($fit as $f): ?><div class="faq-item"><p><?= e($f) ?></p></div><?php endforeach; ?>
  <?php else: ?>
    <div class="faq-item"><p><?= e(t('compare.fit_tied', $lang)) ?></p></div>
  <?php endif; ?>

  <div class="two-col" style="margin-top:30px;">
    <a class="btn btn-ghost btn-block" href="<?= e(url_for($lang, 'mobile', ['slug' => $a['slug']])) ?>"><?= e(t('compare.view_sheet', $lang, ['name' => $nameA])) ?></a>
    <a class="btn btn-ghost btn-block" href="<?= e(url_for($lang, 'mobile', ['slug' => $b['slug']])) ?>"><?= e(t('compare.view_sheet', $lang, ['name' => $nameB])) ?></a>
  </div>

  <div class="cta-strip">
    <div><h3 style="font-size:17px;"><?= e(t('compare.cta_title', $lang)) ?></h3><p class="muted" style="margin:4px 0 0;font-size:13.5px;"><?= e(t('compare.cta_text', $lang)) ?></p></div>
    <a class="btn btn-primary" href="<?= e(spa_url($lang, '/quiz')) ?>"><?= e(t('phone.cta_button', $lang)) ?></a>
  </div>
</section>
</main>

<?php render_footer($lang); ?>
</body>
</html>
