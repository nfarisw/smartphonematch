<?php
/**
 * /{lang}/moviles|mobiles/marca|brand/{slug} — todos los móviles de una
 * marca, página indexable propia. Reutiliza la misma base de datos que el
 * resto del sitio.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';

$lang = resolve_lang();
$market = resolve_market($lang);

$slug = preg_replace('/[^a-z0-9-]/', '', $_GET['slug'] ?? '');
if ($slug === '') { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }

function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
$eur = fn($min, $max) => fmt_price($market, $min, $max);

try {
    $bstmt = db()->prepare("SELECT * FROM brands WHERE slug = :slug");
    $bstmt->execute([':slug' => $slug]);
    $brand = $bstmt->fetch();
    if (!$brand) { http_response_code(404); include __DIR__ . '/../moviles-404.php'; exit; }

    $stmt = db()->prepare(
        "SELECT slug, model, price_min, price_max, price_verified, value_score
         FROM smartphones WHERE brand_id = :bid AND active = 1
         ORDER BY price_verified DESC, value_score DESC"
    );
    $stmt->execute([':bid' => $brand['id']]);
    $phones = $stmt->fetchAll();
} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    echo "Server error.";
    exit;
}

$count = count($phones);
$minPrice = $count ? min(array_column($phones, 'price_min')) : 0;
$fromPrice = $count ? t('brand.from_price', $lang, ['price' => fmt_price($market, $minPrice, $minPrice)]) : '';
$title = t('brand.heading', $lang, ['brand' => $brand['name']]) . " — " . t('brand.title_suffix', $lang) . " | SmartPhoneMatch";
$description = t('brand.description', $lang, ['brand' => $brand['name'], 'count' => $count, 'from_price' => $fromPrice]);

$breadcrumbSchema = [
  "@context" => "https://schema.org", "@type" => "BreadcrumbList",
  "itemListElement" => [
    ["@type" => "ListItem", "position" => 1, "name" => "SmartPhoneMatch", "item" => "http://x/"], // se sustituye abajo
    ["@type" => "ListItem", "position" => 2, "name" => $brand['name'], "item" => "http://x/"],
  ],
];
[$scheme, $host] = current_scheme_host();
$breadcrumbSchema['itemListElement'][0]['item'] = "$scheme://$host" . url_for($lang, 'home');
$breadcrumbSchema['itemListElement'][1]['item'] = "$scheme://$host" . url_for($lang, 'brand', ['slug' => $brand['slug']]);
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e($description) ?>">
<?php render_hreflang($lang, 'brand', ['slug' => $brand['slug']]); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<meta property="og:description" content="<?= e($description) ?>">
<?php render_head_common(); ?>
<script type="application/ld+json"><?= json_encode($breadcrumbSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
<style>.deal-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:16px;margin-top:10px;}
.deal-card{border:1px solid var(--border);border-radius:16px;padding:18px;background:var(--surface);display:flex;flex-direction:column;gap:10px;}
.deal-card:hover{border-color:var(--accent-dim);}
.deal-top{display:flex;gap:12px;align-items:center;}
.deal-name{font-weight:600;font-size:14.5px;}
.deal-price{font-family:var(--font-mono);color:var(--accent);font-size:17px;}</style>
</head>
<body>
<?php render_chrome_open($lang, 'mobiles'); ?>

<main>
<nav class="breadcrumbs" aria-label="Breadcrumb">
  <a href="<?= e(url_for($lang, 'home')) ?>">SmartPhoneMatch</a><span class="sep">/</span><span><?= e($brand['name']) ?></span>
</nav>

<section class="view" style="padding:36px 0 10px;">
  <div class="eyebrow"><?= e(t('brand.eyebrow', $lang)) ?></div>
  <h1 style="font-size:32px;"><?= e(t('brand.heading', $lang, ['brand' => $brand['name']])) ?></h1>
  <p class="muted" style="margin-top:10px;max-width:640px;">
    <?= e(t('brand.summary', $lang, ['count' => $count, 'brand' => $brand['name'], 'from_price' => $fromPrice])) ?>
  </p>

  <?php if (!$phones): ?>
    <div class="empty"><?= e(t('brand.empty', $lang, ['brand' => $brand['name']])) ?></div>
  <?php else: ?>
  <div class="deal-grid">
    <?php foreach ($phones as $p): ?>
      <a class="deal-card" href="<?= e(url_for($lang, 'mobile', ['slug' => $p['slug']])) ?>">
        <div class="deal-top">
          <div class="phone-art" style="width:56px;height:56px;">
            <img src="/images/phones/<?= e($p['slug']) ?>.jpg" alt="<?= e($brand['name'] . ' ' . $p['model']) ?>" loading="lazy">
          </div>
          <div class="deal-name"><?= e($p['model']) ?></div>
        </div>
        <div class="deal-price">~<?= $eur($p['price_min'], $p['price_max']) ?></div>
        <div style="display:flex;gap:6px;flex-wrap:wrap;">
          <?php if ($market === 'ES' && $p['price_verified']): ?><span class="chip" style="color:var(--accent);border-color:var(--accent-dim);font-size:10.5px;"><?= e(t('brand.verified', $lang)) ?></span>
          <?php else: ?><span class="chip" style="font-size:10.5px;"><?= e(t('brand.estimated', $lang)) ?></span><?php endif; ?>
          <span class="chip" style="font-size:10.5px;"><?= e(t('brand.value_score', $lang, ['score' => (int)$p['value_score']])) ?></span>
        </div>
      </a>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <?php if ($count >= 2): ?>
  <p style="margin-top:10px;"><a class="chip" href="<?= e(url_for($lang, 'compare', ['a' => $phones[0]['slug'], 'b' => $phones[1]['slug']])) ?>"><?= e(t('brand.compare_top2', $lang, ['brand' => $brand['name']])) ?></a></p>
  <?php endif; ?>

  <div class="cta-strip">
    <div><h3 style="font-size:17px;"><?= e(t('brand.cta_title', $lang)) ?></h3><p class="muted" style="margin:4px 0 0;font-size:13.5px;"><?= e(t('brand.cta_text', $lang)) ?></p></div>
    <a class="btn btn-primary" href="<?= e(spa_url($lang, '/quiz')) ?>"><?= e(t('phone.cta_button', $lang)) ?></a>
  </div>
</section>
</main>

<?php render_footer($lang); ?>
</body>
</html>
