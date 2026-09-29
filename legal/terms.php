<?php
/**
 * /{lang}/aviso-legal|legal-notice — identificación del titular (Art. 10
 * LSSI), objeto del sitio, propiedad intelectual, enlaces de afiliado,
 * responsabilidad y legislación aplicable.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';
require __DIR__ . '/legal-config.php';

$lang = resolve_lang();
function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }

$title = t('legal.terms_title', $lang) . ' — SmartPhoneMatch';
$updated = date('Y-m-d');
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e(t('terms.purpose_text', $lang)) ?>">
<?php render_hreflang($lang, 'legal'); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<?php render_head_common(); ?>
</head>
<body>
<?php render_chrome_open($lang, null); ?>

<main>
  <div class="view">
    <p class="eyebrow"><?= e(t('terms.eyebrow', $lang)) ?></p>
    <h1><?= e(t('terms.heading', $lang)) ?></h1>
    <p class="faint"><?= t('terms.updated', $lang, ['date' => e($updated)]) ?></p>

    <h2><?= e(t('terms.identity_heading', $lang)) ?></h2>
    <p><?= t('terms.identity_text', $lang, [
      'owner_name' => e(SITE_OWNER_NAME),
      'owner_id' => e(SITE_OWNER_ID),
      'owner_address' => e(SITE_OWNER_ADDRESS),
      'owner_email' => e(SITE_OWNER_EMAIL),
    ]) ?></p>

    <h2><?= e(t('terms.purpose_heading', $lang)) ?></h2>
    <p><?= e(t('terms.purpose_text', $lang)) ?></p>

    <h2><?= e(t('terms.ip_heading', $lang)) ?></h2>
    <p><?= t('terms.ip_text', $lang, ['owner_name' => e(SITE_OWNER_NAME)]) ?></p>

    <h2><?= e(t('terms.links_heading', $lang)) ?></h2>
    <p><?= e(t('terms.links_text', $lang)) ?></p>

    <h2><?= e(t('terms.liability_heading', $lang)) ?></h2>
    <p><?= e(t('terms.liability_text', $lang)) ?></p>

    <h2><?= e(t('terms.law_heading', $lang)) ?></h2>
    <p><?= e(t('terms.law_text', $lang)) ?></p>
  </div>
</main>

<?php render_footer($lang); ?>
</body>
</html>
