<?php
/**
 * /{lang}/moviles/mejores-moviles-{max}-euros o
 * /{lang}/mobiles/best-phones-{max}-euros — incluido desde index.php cuando
 * el slug tiene forma de presupuesto. $_GET['max'] ya viene validado como
 * entero desde el router. Todo el contenido (móviles, FAQ) sale de datos
 * reales de la base de datos, nada de texto de relleno genérico.
 */
if (!function_exists('e')) { function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); } }
require_once __DIR__ . '/../lang/i18n.php';
$lang = $lang ?? resolve_lang();
$market = $market ?? resolve_market($lang);
$eur = fn($min, $max) => fmt_price($market, $min, $max);

$max = (int)($_GET['max'] ?? 0);
if ($max < 50 || $max > 3000) { http_response_code(404); include __DIR__ . '/../moviles-404.php'; return; }

try {
    $stmt = db()->prepare(
        "SELECT s.slug, s.model, s.price_min, s.price_max, s.price_verified, s.value_score,
                b.name AS brand_name
         FROM smartphones s JOIN brands b ON b.id = s.brand_id
         WHERE s.active = 1 AND s.price_min <= :max
         ORDER BY s.price_verified DESC, s.value_score DESC"
    );
    $stmt->execute([':max' => $max]);
    $phones = $stmt->fetchAll();
} catch (Throwable $e) {
    error_log($e->getMessage());
    http_response_code(500);
    echo "Server error.";
    exit;
}

[$scheme, $host] = current_scheme_host();
$count = count($phones);
$title = t('budget.title', $lang, ['max' => $max, 'year' => date('Y')]) . " — SmartPhoneMatch";
$description = t('budget.description', $lang, ['count' => $count, 'max' => $max]);

// FAQ generada solo con datos reales — si no hay un móvil de una marca en
// este presupuesto, no se inventa la pregunta.
$faqs = [];
if ($count) {
    $top = $phones[0];
    $faqs[] = [
        t('budget.faq_best_q', $lang, ['max' => $max]),
        t('budget.faq_best_a', $lang, ['brand' => $top['brand_name'], 'model' => $top['model'], 'price' => $eur($top['price_min'], $top['price_max']), 'max' => $max]),
    ];
    $verifiedInBudget = $market === 'ES' ? array_filter($phones, fn($p) => $p['price_verified']) : [];
    if ($verifiedInBudget) {
        $faqs[] = [t('budget.faq_verified_q', $lang), t('budget.faq_verified_a', $lang, ['verified' => count($verifiedInBudget), 'count' => $count])];
    }
}
$faqSchema = $faqs ? [
  "@context" => "https://schema.org", "@type" => "FAQPage",
  "mainEntity" => array_map(fn($f) => [
      "@type" => "Question", "name" => $f[0],
      "acceptedAnswer" => ["@type" => "Answer", "text" => $f[1]],
  ], $faqs),
] : null;
$breadcrumbSchema = [
  "@context" => "https://schema.org", "@type" => "BreadcrumbList",
  "itemListElement" => [
    ["@type" => "ListItem", "position" => 1, "name" => "SmartPhoneMatch", "item" => "$scheme://$host" . url_for($lang, 'home')],
    ["@type" => "ListItem", "position" => 2, "name" => t('budget.breadcrumb_deals', $lang), "item" => "$scheme://$host" . url_for($lang, 'deals')],
    ["@type" => "ListItem", "position" => 3, "name" => t('budget.breadcrumb', $lang, ['max' => $max]), "item" => "$scheme://$host" . url_for($lang, 'budget', ['max' => $max])],
  ],
];
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e($description) ?>">
<?php render_hreflang($lang, 'budget', ['max' => $max]); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<meta property="og:description" content="<?= e($description) ?>">
<?php render_head_common(); ?>
<script type="application/ld+json"><?= json_encode($breadcrumbSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
<?php if ($faqSchema): ?><script type="application/ld+json"><?= json_encode($faqSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script><?php endif; ?>
<style>.deal-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:16px;margin-top:10px;}
.deal-card{border:1px solid var(--border);border-radius:16px;padding:18px;background:var(--surface);display:flex;flex-direction:column;gap:10px;}
.deal-card:hover{border-color:var(--accent-dim);}
.deal-top{display:flex;gap:12px;align-items:center;}
.deal-name{font-weight:600;font-size:14.5px;}
.deal-brand{font-size:11.5px;color:var(--text-faint);font-family:var(--font-mono);}
.deal-price{font-family:var(--font-mono);color:var(--accent);font-size:17px;}</style>
</head>
<body>
<?php render_chrome_open($lang, 'mobiles'); ?>

<main>
<nav class="breadcrumbs" aria-label="Breadcrumb">
  <a href="<?= e(url_for($lang, 'home')) ?>">SmartPhoneMatch</a><span class="sep">/</span>
  <a href="<?= e(url_for($lang, 'deals')) ?>"><?= e(t('budget.breadcrumb_deals', $lang)) ?></a><span class="sep">/</span>
  <span><?= e(t('budget.breadcrumb', $lang, ['max' => $max])) ?></span>
</nav>

<section class="view" style="padding:36px 0 10px;">
  <div class="eyebrow"><?= e(t('budget.eyebrow', $lang)) ?></div>
  <h1 style="font-size:32px;"><?= e(t('budget.heading', $lang, ['max' => $max])) ?></h1>
  <p class="muted" style="margin-top:10px;max-width:640px;">
    <?= e(t('budget.summary', $lang, ['count' => $count])) ?>
  </p>

  <?php if (!$phones): ?>
    <div class="empty"><?= e(t('budget.empty', $lang, ['max' => $max])) ?></div>
  <?php else: ?>
  <div class="deal-grid">
    <?php foreach ($phones as $p): ?>
      <a class="deal-card" href="<?= e(url_for($lang, 'mobile', ['slug' => $p['slug']])) ?>">
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
      </a>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <?php if ($faqs): ?>
  <div class="section-head"><h2 style="font-size:20px;"><?= e(t('budget.faq_heading', $lang)) ?></h2></div>
  <?php foreach ($faqs as [$q, $a]): ?>
    <div class="faq-item"><h3><?= e($q) ?></h3><p><?= e($a) ?></p></div>
  <?php endforeach; ?>
  <?php endif; ?>

  <?php if ($count >= 2): ?>
  <p style="margin-top:10px;"><a class="chip" href="<?= e(url_for($lang, 'compare', ['a' => $phones[0]['slug'], 'b' => $phones[1]['slug']])) ?>"><?= e(t('budget.compare_top2', $lang, ['max' => $max])) ?></a></p>
  <?php endif; ?>

  <div class="cta-strip">
    <div><h3 style="font-size:17px;"><?= e(t('budget.cta_title', $lang)) ?></h3><p class="muted" style="margin:4px 0 0;font-size:13.5px;"><?= e(t('budget.cta_text', $lang)) ?></p></div>
    <a class="btn btn-primary" href="<?= e(spa_url($lang, '/quiz')) ?>"><?= e(t('phone.cta_button', $lang)) ?></a>
  </div>
</section>
</main>

<?php render_footer($lang); ?>
</body>
</html>
