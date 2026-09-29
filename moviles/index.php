<?php
/**
 * Ficha de móvil renderizada en servidor — URL real e indexable
 * (/{lang}/moviles|mobiles/{slug}), a diferencia de la SPA (#/moviles/{slug})
 * que Google no puede tratar como una página independiente. Reutiliza la
 * misma base de datos y la misma función de etiqueta de afiliado que la
 * API JSON, y el mismo diccionario de traducciones que el resto del sitio.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';

$lang = resolve_lang();
$market = resolve_market($lang);
$seg = SPM_SEGMENTS[$lang];

$slug = preg_replace('/[^a-z0-9-]/', '', $_GET['slug'] ?? '');
if ($slug === '') { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }

// /moviles/mejores-moviles-300-euros (o /mobiles/best-phones-300-euros en
// inglés) no es un móvil — es una página de presupuesto. Mismo router,
// delega en un archivo aparte. El patrón se arma con los segmentos del
// idioma actual, no está hardcodeado en español.
$budgetPattern = '/^' . preg_quote($seg['budget_prefix'], '/') . '(\d+)' . preg_quote($seg['budget_suffix'], '/') . '$/';
if (preg_match($budgetPattern, $slug, $m)) {
    $_GET['max'] = (int)$m[1];
    require __DIR__ . '/presupuesto.php';
    exit;
}

try {
    $stmt = db()->prepare(
        "SELECT s.*, b.name AS brand_name, b.slug AS brand_slug
         FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.slug = :slug AND s.active = 1"
    );
    $stmt->execute([':slug' => $slug]);
    $p = $stmt->fetch();
    if (!$p) { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }

    // Solo retailers del mercado actual — ES ve Amazon.es/PcComponentes/
    // MediaMarkt, US ve Amazon.com/Best Buy/Walmart, nunca mezclados.
    $links = db()->prepare(
        "SELECT p.condition, p.refurb_grade, p.url, r.name AS retailer_name, r.slug AS retailer_slug
         FROM prices p JOIN retailers r ON r.id = p.retailer_id
         WHERE p.smartphone_id = :id AND r.market = :market ORDER BY p.condition, r.name"
    );
    $links->execute([':id' => $p['id'], ':market' => $market]);
    $offers = $links->fetchAll();
    foreach ($offers as &$o) { $o['url'] = apply_amazon_tag($o['url'], $market); }
    unset($o);
    $nuevo = array_values(array_filter($offers, fn($o) => $o['condition'] === 'nuevo'));
    $refurb = array_values(array_filter($offers, fn($o) => $o['condition'] === 'reacondicionado'));

    // Alternativas: misma marca (excluyéndose) y opciones más baratas con buena
    // relación calidad/precio — mismos datos que ya tenemos, sin nada inventado.
    $sameBrand = db()->prepare(
        "SELECT s.slug, s.model, b.name AS brand_name, s.price_min, s.price_max
         FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.brand_id = :bid AND s.id != :id AND s.active = 1
         ORDER BY s.value_score DESC LIMIT 4"
    );
    $sameBrand->execute([':bid' => $p['brand_id'], ':id' => $p['id']]);
    $altSameBrand = $sameBrand->fetchAll();

    $cheaper = db()->prepare(
        "SELECT s.slug, s.model, b.name AS brand_name, s.price_min, s.price_max
         FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.price_max < :maxp AND s.id != :id AND s.active = 1
         ORDER BY s.value_score DESC LIMIT 4"
    );
    $cheaper->execute([':maxp' => $p['price_min'], ':id' => $p['id']]);
    $altCheaper = $cheaper->fetchAll();
} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    echo "Server error.";
    exit;
}

function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
// fmt_price() (lang/i18n.php) formatea en € u $ según el mercado sobre el
// MISMO precio de catálogo — no hay una tabla de precios propia de EE. UU.
// todavía (no la inventamos), así que para cualquier mercado que no sea ES
// el rango se marca siempre como "sin verificar" más abajo.
$eur = fn($min, $max) => fmt_price($market, $min, $max);

[$scheme, $host] = current_scheme_host();
$brandName = "{$p['brand_name']} {$p['model']}";
$title = "$brandName — " . t('phone.title_suffix', $lang) . " | SmartPhoneMatch";
$description = t('phone.description', $lang, [
    'brand' => $p['brand_name'], 'model' => $p['model'], 'screen' => $p['screen_size'],
    'cpu' => $p['processor'], 'ram' => $p['ram'], 'battery' => $p['battery_mah'],
    'price' => $eur($p['price_min'], $p['price_max']),
]);
$verified = $market === 'ES' && (bool)$p['price_verified'];

$specRows = [
  [t('spec.screen', $lang), $p['screen_size']], [t('spec.refresh', $lang), $p['refresh_rate']], [t('spec.cpu', $lang), $p['processor']],
  [t('spec.ram', $lang), $p['ram']], [t('spec.storage', $lang), $p['storage']], [t('spec.battery', $lang), $p['battery_mah']],
  [t('spec.fast_charging', $lang), $p['fast_charging']], [t('spec.main_camera', $lang), $p['main_camera']],
  [t('spec.ultrawide', $lang), $p['ultrawide_camera']], [t('spec.telephoto', $lang), $p['telephoto']],
  [t('spec.front_camera', $lang), $p['front_camera']], [t('spec.weight', $lang), $p['weight']], [t('spec.water', $lang), $p['water_resistance']],
  [t('spec.updates', $lang), $p['update_years']], [t('spec.5g', $lang), $p['has_5g'] ? t('spec.yes', $lang) : t('spec.no', $lang)],
  [t('spec.nfc', $lang), $p['has_nfc'] ? t('spec.yes', $lang) : t('spec.no', $lang)], [t('spec.esim', $lang), $p['has_esim'] ? t('spec.yes', $lang) : t('spec.no', $lang)],
  [t('spec.wireless', $lang), $p['wireless_charging'] ? t('spec.yes', $lang) : t('spec.no', $lang)],
];
$scores = [
  [t('score.camera', $lang), $p['photo_score']], [t('score.performance', $lang), $p['performance_score']], [t('score.gaming', $lang), $p['gaming_score']],
  [t('score.battery', $lang), $p['battery_score']], [t('score.screen', $lang), $p['screen_score']], [t('score.value', $lang), $p['value_score']],
];

$productSchema = [
  "@context" => "https://schema.org", "@type" => "Product",
  "name" => $brandName,
  "brand" => ["@type" => "Brand", "name" => $p['brand_name']],
  "offers" => [
    "@type" => "AggregateOffer", "priceCurrency" => $market === 'US' ? 'USD' : 'EUR',
    "lowPrice" => (float)$p['price_min'], "highPrice" => (float)$p['price_max'],
    "offerCount" => max(1, count($nuevo)),
  ],
];
$breadcrumbSchema = [
  "@context" => "https://schema.org", "@type" => "BreadcrumbList",
  "itemListElement" => [
    ["@type" => "ListItem", "position" => 1, "name" => "SmartPhoneMatch", "item" => "$scheme://$host" . url_for($lang, 'home')],
    ["@type" => "ListItem", "position" => 2, "name" => $p['brand_name'], "item" => "$scheme://$host" . url_for($lang, 'brand', ['slug' => $p['brand_slug']])],
    ["@type" => "ListItem", "position" => 3, "name" => $p['model'], "item" => "$scheme://$host" . url_for($lang, 'mobile', ['slug' => $p['slug']])],
  ],
];
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e($description) ?>">
<?php render_hreflang($lang, 'mobile', ['slug' => $p['slug']]); ?>
<meta property="og:type" content="product">
<meta property="og:locale" content="<?= e(t('meta.locale', $lang)) ?>">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($brandName) ?>">
<meta property="og:description" content="<?= e($description) ?>">
<meta property="og:image" content="<?= e("$scheme://$host/images/phones/{$p['slug']}.jpg") ?>">
<meta name="twitter:card" content="summary_large_image">
<?php render_head_common(); ?>
<script type="application/ld+json"><?= json_encode($productSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
<script type="application/ld+json"><?= json_encode($breadcrumbSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
</head>
<body>
<?php render_chrome_open($lang, 'mobiles'); ?>

<main>
<nav class="breadcrumbs" aria-label="Breadcrumb">
  <a href="<?= e(url_for($lang, 'home')) ?>">SmartPhoneMatch</a><span class="sep">/</span>
  <a href="<?= e(url_for($lang, 'brand', ['slug' => $p['brand_slug']])) ?>"><?= e($p['brand_name']) ?></a><span class="sep">/</span>
  <span><?= e($p['model']) ?></span>
</nav>

<section class="view">
  <div class="detail-head">
    <div class="phone-art" style="width:132px;height:132px;">
      <img src="/images/phones/<?= e($p['slug']) ?>.jpg" alt="<?= e($brandName) ?>" loading="lazy">
    </div>
    <div>
      <div class="eyebrow"><?= e($p['brand_name']) ?> · <?= e($p['os']) ?></div>
      <h1><?= e($brandName) ?></h1>
      <div class="price-tag mono" style="margin-top:8px;">
        ~<?= $eur($p['price_min'], $p['price_max']) ?>
        <?php if ($verified): ?><span class="chip" style="color:var(--accent);border-color:var(--accent-dim);"><?= e(t('phone.range_verified', $lang)) ?></span>
        <?php else: ?><span class="chip"><?= e(t('phone.range_unverified', $lang)) ?></span><?php endif; ?>
      </div>
    </div>
  </div>

  <h2 style="font-size:17px;margin-top:36px;"><?= e(t('phone.scores_heading', $lang)) ?></h2>
  <p class="data-note"><?= e(t('phone.scores_note', $lang)) ?></p>
  <div class="score-grid">
    <?php foreach ($scores as [$label, $val]): ?>
      <div class="score-pill"><div class="val"><?= e($val) ?></div><div class="lbl"><?= e($label) ?></div></div>
    <?php endforeach; ?>
  </div>

  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('phone.specs_heading', $lang)) ?></h2></div>
  <div class="spec-grid">
    <?php foreach ($specRows as [$label, $val]): ?>
      <div class="spec-row"><span><?= e(mb_strtoupper($label)) ?></span><span><?= e($val ?: '—') ?></span></div>
    <?php endforeach; ?>
  </div>

  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('phone.where_to_buy', $lang)) ?></h2></div>
  <?php if ($nuevo): ?>
  <div class="offers">
    <?php foreach ($nuevo as $o): ?>
      <div class="offer-row">
        <span class="r-name"><?= e($o['retailer_name']) ?></span>
        <a class="btn btn-primary btn-sm" href="<?= e($o['url']) ?>" target="_blank" rel="noopener noreferrer nofollow sponsored"><?= e(t('phone.view_offer_at', $lang, ['retailer' => $o['retailer_name']])) ?></a>
      </div>
    <?php endforeach; ?>
  </div>
  <?php else: ?><p class="muted"><?= e(t('phone.no_retailers', $lang)) ?></p><?php endif; ?>

  <?php if ($refurb): ?>
  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('phone.refurbished', $lang)) ?></h2><span class="chip"><?= e(t('phone.refurbished_from', $lang, ['price' => $eur($p['refurb_price_min'], $p['refurb_price_max'])])) ?></span></div>
  <div class="offers">
    <?php foreach ($refurb as $o): ?>
      <div class="offer-row">
        <span class="r-name"><?= e($o['retailer_name']) ?> <span class="chip" style="margin-left:6px;"><?= e(t('phone.refurbished_grade', $lang)) ?> · <?= e($o['refurb_grade']) ?></span></span>
        <a class="btn btn-ghost btn-sm" href="<?= e($o['url']) ?>" target="_blank" rel="noopener noreferrer nofollow sponsored"><?= e(t('phone.view_offer_at', $lang, ['retailer' => $o['retailer_name']])) ?></a>
      </div>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <?php if ($altCheaper): ?>
  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('phone.cheaper_heading', $lang)) ?></h2></div>
  <div class="alt-grid">
    <?php foreach ($altCheaper as $a): ?>
      <a class="alt-card" href="<?= e(url_for($lang, 'mobile', ['slug' => $a['slug']])) ?>">
        <div class="alt-name"><?= e($a['brand_name'] . ' ' . $a['model']) ?></div>
        <div class="alt-price">~<?= $eur($a['price_min'], $a['price_max']) ?></div>
      </a>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <?php if ($altSameBrand): ?>
  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('phone.more_from_brand', $lang, ['brand' => $p['brand_name']])) ?></h2></div>
  <div class="alt-grid">
    <?php foreach ($altSameBrand as $a): ?>
      <a class="alt-card" href="<?= e(url_for($lang, 'mobile', ['slug' => $a['slug']])) ?>">
        <div class="alt-name"><?= e($a['model']) ?></div>
        <div class="alt-price">~<?= $eur($a['price_min'], $a['price_max']) ?></div>
      </a>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <div class="cta-strip">
    <div><h3 style="font-size:17px;"><?= e(t('phone.cta_title', $lang)) ?></h3><p class="muted" style="margin:4px 0 0;font-size:13.5px;"><?= e(t('phone.cta_text', $lang)) ?></p></div>
    <a class="btn btn-primary" href="<?= e(spa_url($lang, '/quiz')) ?>"><?= e(t('phone.cta_button', $lang)) ?></a>
  </div>
</section>
</main>

<?php render_footer($lang); ?>
</body>
</html>
