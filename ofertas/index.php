<?php
/**
 * /{lang}/ofertas|deals — catálogo filtrable por presupuesto/marca, ordenado
 * por precio o relación calidad-precio, con búsqueda por texto en cliente.
 * A propósito NO muestra "% de descuento" ni "oferta real": para eso hace
 * falta histórico de precios (aún no existe) y no queremos inventar un dato
 * que no tenemos. Lo que sí mostramos (rango de precio, si está verificado,
 * y la puntuación de calidad/precio) es 100% real.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';

$lang = resolve_lang();
$market = resolve_market($lang);

$BUDGET_KEYS = ['', 'lt200', '200-300', '300-500', '500-800', 'gt800'];
$BUDGETS = [
  ''        => t('deals.budget_all', $lang),
  'lt200'   => t('deals.budget_lt200', $lang),
  '200-300' => t('deals.budget_200_300', $lang),
  '300-500' => t('deals.budget_300_500', $lang),
  '500-800' => t('deals.budget_500_800', $lang),
  'gt800'   => t('deals.budget_gt800', $lang),
];
$BUDGET_RANGES = [
  'lt200'   => [0, 200], '200-300' => [200, 300], '300-500' => [300, 500],
  '500-800' => [500, 800], 'gt800' => [800, 999999],
];
$ORDER_KEYS = ['verificados', 'precio-asc', 'precio-desc', 'valor'];
$ORDERS = [
  'verificados' => t('deals.sort_verified', $lang),
  'precio-asc'  => t('deals.sort_price_asc', $lang),
  'precio-desc' => t('deals.sort_price_desc', $lang),
  'valor'       => t('deals.sort_value', $lang),
];

$budget = $_GET['presupuesto'] ?? '';
$brandSlug = $_GET['marca'] ?? '';
$order = $_GET['orden'] ?? 'verificados';
if (!in_array($budget, $BUDGET_KEYS, true)) $budget = '';
if (!in_array($order, $ORDER_KEYS, true)) $order = 'verificados';

function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
$eur = fn($min, $max) => fmt_price($market, $min, $max);

try {
    $brands = db()->query("SELECT id, name, slug FROM brands ORDER BY name")->fetchAll();

    $where = ["s.active = 1"];
    $params = [];
    if ($budget && isset($BUDGET_RANGES[$budget])) {
        [$lo, $hi] = $BUDGET_RANGES[$budget];
        $where[] = "s.price_min <= :hi AND s.price_max >= :lo";
        $params[':hi'] = $hi; $params[':lo'] = $lo;
    }
    if ($brandSlug) { $where[] = "b.slug = :bslug"; $params[':bslug'] = $brandSlug; }
    $params[':market'] = $market;

    $orderSql = match ($order) {
        'precio-asc'  => 's.price_min ASC',
        'precio-desc' => 's.price_min DESC',
        'valor'       => 's.value_score DESC, s.price_min ASC',
        default       => 's.price_verified DESC, s.value_score DESC',
    };

    // Las subconsultas de "mejor oferta" se limitan al retailer del mercado
    // activo, para que una ficha en inglés/US nunca enseñe PcComponentes ni
    // MediaMarkt, ni una en español enseñe Best Buy/Walmart.
    $sql = "SELECT s.slug, s.model, s.price_min, s.price_max, s.price_verified, s.value_score,
                   b.name AS brand_name,
                   (SELECT p.url FROM prices p JOIN retailers r ON r.id = p.retailer_id
                    WHERE p.smartphone_id = s.id AND p.condition = 'nuevo' AND p.url IS NOT NULL AND r.market = :market
                    ORDER BY r.name LIMIT 1) AS best_url,
                   (SELECT r.name FROM prices p JOIN retailers r ON r.id = p.retailer_id
                    WHERE p.smartphone_id = s.id AND p.condition = 'nuevo' AND p.url IS NOT NULL AND r.market = :market
                    ORDER BY r.name LIMIT 1) AS best_retailer
            FROM smartphones s JOIN brands b ON b.id = s.brand_id
            WHERE " . implode(' AND ', $where) . "
            ORDER BY $orderSql";
    $stmt = db()->prepare($sql);
    $stmt->execute($params);
    $phones = $stmt->fetchAll();
    foreach ($phones as &$ph) { if ($ph['best_url']) $ph['best_url'] = apply_amazon_tag($ph['best_url'], $market); }
    unset($ph);
} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    echo "Server error.";
    exit;
}

function qs($overrides) {
    $params = array_merge(['presupuesto' => $_GET['presupuesto'] ?? '', 'marca' => $_GET['marca'] ?? '', 'orden' => $_GET['orden'] ?? ''], $overrides);
    $params = array_filter($params, fn($v) => $v !== '');
    return $params ? '?' . http_build_query($params) : '';
}

[$scheme, $host] = current_scheme_host();
$verifiedCount = $market === 'ES' ? count(array_filter($phones, fn($p) => $p['price_verified'])) : 0;
$title = t('deals.title', $lang) . ($brandSlug ? ' ' . ucfirst($brandSlug) : '') . " — SmartPhoneMatch";

$itemListSchema = [
  "@context" => "https://schema.org", "@type" => "ItemList",
  "itemListElement" => array_values(array_map(function($p, $i) use ($lang) {
      return ["@type" => "ListItem", "position" => $i + 1, "url" => url_for($lang, 'mobile', ['slug' => $p['slug']])];
  }, array_slice($phones, 0, 20), array_keys(array_slice($phones, 0, 20)))),
];
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e(t('deals.description', $lang)) ?>">
<?php render_hreflang($lang, 'deals'); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e(t('deals.title', $lang)) ?> — SmartPhoneMatch">
<?php render_head_common(); ?>
<script type="application/ld+json"><?= json_encode($itemListSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
<style>
  .filter-bar{display:flex;flex-wrap:wrap;gap:10px;margin:24px 0;align-items:center;}
  .filter-group{display:flex;flex-wrap:wrap;gap:6px;}
  .filter-chip{font-family:var(--font-mono);font-size:12.5px;padding:7px 14px;border-radius:20px;border:1px solid var(--border);color:var(--text-muted);}
  .filter-chip:hover{border-color:var(--accent-dim);color:var(--text);}
  .filter-chip.active{border-color:var(--accent);color:var(--accent);background:rgba(69,224,199,.08);}
  select.sort-select{background:var(--surface);color:var(--text);border:1px solid var(--border);border-radius:10px;padding:9px 12px;font-family:var(--font-body);font-size:13.5px;}
  .deals-search{flex:1;min-width:200px;background:var(--surface);color:var(--text);border:1px solid var(--border);border-radius:10px;padding:9px 14px;font-family:var(--font-body);font-size:13.5px;}
  .deal-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:16px;margin-top:10px;}
  .deal-card{border:1px solid var(--border);border-radius:16px;padding:18px;background:var(--surface);display:flex;flex-direction:column;gap:10px;}
  .deal-card:hover{border-color:var(--accent-dim);}
  .deal-top{display:flex;gap:12px;align-items:center;}
  .deal-name{font-weight:600;font-size:14.5px;}
  .deal-brand{font-size:11.5px;color:var(--text-faint);font-family:var(--font-mono);}
  .deal-price{font-family:var(--font-mono);color:var(--accent);font-size:17px;}
</style>
</head>
<body>
<?php render_chrome_open($lang, 'deals'); ?>

<main>
<nav class="breadcrumbs" aria-label="Breadcrumb">
  <a href="<?= e(url_for($lang, 'home')) ?>">SmartPhoneMatch</a><span class="sep">/</span><span><?= e(t('deals.breadcrumb', $lang)) ?></span>
</nav>

<section class="view" style="padding:36px 0 10px;">
  <div class="eyebrow"><?= e(t('deals.eyebrow', $lang)) ?></div>
  <h1 style="font-size:32px;"><?= e(t('deals.heading', $lang)) ?></h1>
  <p class="muted" style="margin-top:10px;max-width:640px;">
    <?= e(t('deals.summary', $lang, ['verified' => $verifiedCount, 'count' => count($phones)])) ?>
  </p>

  <form class="filter-bar" method="get">
    <input type="search" class="deals-search" id="deals-search" placeholder="<?= e(t('deals.search_placeholder', $lang)) ?>" aria-label="<?= e(t('deals.search_placeholder', $lang)) ?>">
  </form>
  <form class="filter-bar" method="get">
    <div class="filter-group">
      <?php foreach ($BUDGETS as $key => $label): ?>
        <a class="filter-chip <?= $budget === $key ? 'active' : '' ?>" href="<?= e(url_for($lang, 'deals')) ?><?= qs(['presupuesto' => $key]) ?>"><?= e($label) ?></a>
      <?php endforeach; ?>
    </div>
  </form>
  <form class="filter-bar" method="get" style="margin-top:0;">
    <div class="filter-group">
      <a class="filter-chip <?= $brandSlug === '' ? 'active' : '' ?>" href="<?= e(url_for($lang, 'deals')) ?><?= qs(['marca' => '']) ?>"><?= e(t('deals.all_brands', $lang)) ?></a>
      <?php foreach ($brands as $b): ?>
        <a class="filter-chip <?= $brandSlug === $b['slug'] ? 'active' : '' ?>" href="<?= e(url_for($lang, 'deals')) ?><?= qs(['marca' => $b['slug']]) ?>"><?= e($b['name']) ?></a>
      <?php endforeach; ?>
    </div>
  </form>
  <div class="filter-bar">
    <label class="faint mono" style="font-size:12px;" for="orden"><?= e(mb_strtoupper(t('deals.sort_label', $lang))) ?></label>
    <select class="sort-select" id="orden" onchange="location.href=this.value">
      <?php foreach ($ORDERS as $key => $label): $url = url_for($lang, 'deals') . qs(['orden' => $key]); ?>
        <option value="<?= e($url) ?>" <?= $order === $key ? 'selected' : '' ?>><?= e($label) ?></option>
      <?php endforeach; ?>
    </select>
  </div>

  <?php if (!$phones): ?>
    <div class="empty"><?= e(t('deals.empty', $lang)) ?></div>
  <?php else: ?>
  <div class="deal-grid" id="deals-grid">
    <?php foreach ($phones as $p): ?>
      <div class="deal-card" data-search="<?= e(mb_strtolower($p['brand_name'] . ' ' . $p['model'])) ?>">
        <div class="deal-top">
          <div class="phone-art" style="width:56px;height:56px;">
            <img src="/images/phones/<?= e($p['slug']) ?>.jpg" alt="<?= e($p['brand_name'] . ' ' . $p['model']) ?>" loading="lazy">
          </div>
          <div>
            <div class="deal-brand"><?= e(mb_strtoupper($p['brand_name'])) ?></div>
            <div class="deal-name"><?= e($p['model']) ?></div>
          </div>
        </div>
        <div class="deal-price">~<?= $eur($p['price_min'], $p['price_max']) ?></div>
        <div style="display:flex;gap:6px;flex-wrap:wrap;">
          <?php if ($market === 'ES' && $p['price_verified']): ?><span class="chip" style="color:var(--accent);border-color:var(--accent-dim);font-size:10.5px;"><?= e(t('brand.verified', $lang)) ?></span>
          <?php else: ?><span class="chip" style="font-size:10.5px;"><?= e(t('brand.estimated', $lang)) ?></span><?php endif; ?>
          <span class="chip" style="font-size:10.5px;"><?= e(t('brand.value_score', $lang, ['score' => (int)$p['value_score']])) ?></span>
        </div>
        <div style="display:flex;gap:8px;margin-top:4px;">
          <a class="btn btn-ghost btn-sm" style="flex:1;justify-content:center;" href="<?= e(url_for($lang, 'mobile', ['slug' => $p['slug']])) ?>"><?= e(t('deals.view_sheet', $lang)) ?></a>
          <?php if ($p['best_url']): ?>
            <a class="btn btn-primary btn-sm js-offer-click" style="flex:1;justify-content:center;" data-retailer="<?= e($p['best_retailer']) ?>" data-phone="<?= e($p['slug']) ?>" href="<?= e($p['best_url']) ?>" target="_blank" rel="noopener noreferrer sponsored"><?= e(t('deals.view_offer', $lang)) ?></a>
          <?php endif; ?>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
  <p class="empty" id="deals-no-search-results" style="display:none;"><?= e(t('spa.no_results_catalog', $lang)) ?></p>
  <?php endif; ?>

  <div class="section-head"><h2 style="font-size:17px;"><?= e(t('deals.guides_heading', $lang)) ?></h2></div>
  <div style="display:flex;gap:8px;flex-wrap:wrap;">
    <?php foreach ([200, 300, 500, 800, 1000] as $bmax): ?>
      <a class="chip" href="<?= e(url_for($lang, 'budget', ['max' => $bmax])) ?>"><?= e(t('deals.guide_under', $lang, ['max' => $bmax])) ?></a>
    <?php endforeach; ?>
  </div>

  <div class="cta-strip">
    <div><h3 style="font-size:17px;"><?= e(t('deals.cta_title', $lang)) ?></h3><p class="muted" style="margin:4px 0 0;font-size:13.5px;"><?= e(t('deals.cta_text', $lang)) ?></p></div>
    <a class="btn btn-primary" href="<?= e(spa_url($lang, '/quiz')) ?>"><?= e(t('phone.cta_button', $lang)) ?></a>
  </div>
</section>
</main>

<?php render_footer($lang); ?>
<script>
document.querySelectorAll(".js-offer-click").forEach(function(el){
  el.addEventListener("click", function(){
    if (typeof gtag === "function") gtag("event", "click_offer", { retailer: el.dataset.retailer, phone_slug: el.dataset.phone, source: "ofertas" });
  });
});
// Búsqueda por texto en cliente sobre las tarjetas ya renderizadas — no
// duplica datos ni hace una petición nueva, solo filtra lo que el servidor
// ya envió con los filtros de presupuesto/marca aplicados.
(function(){
  var input = document.getElementById("deals-search");
  var grid = document.getElementById("deals-grid");
  if (!input || !grid) return;
  var cards = Array.prototype.slice.call(grid.querySelectorAll(".deal-card"));
  var noResults = document.getElementById("deals-no-search-results");
  input.addEventListener("input", function(){
    var q = input.value.trim().toLowerCase();
    var visible = 0;
    cards.forEach(function(card){
      var match = !q || card.dataset.search.indexOf(q) !== -1;
      card.style.display = match ? "" : "none";
      if (match) visible++;
    });
    if (noResults) noResults.style.display = (q && visible === 0) ? "" : "none";
    grid.style.display = (q && visible === 0) ? "none" : "";
  });
})();
</script>
</body>
</html>
