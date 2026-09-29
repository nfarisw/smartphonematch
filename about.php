<?php
/**
 * /{lang}/sobre-nosotros|about — quién hay detrás del sitio y cómo se
 * financia. Google (tanto para SEO como para la revisión de AdSense)
 * espera encontrar esta página enlazada desde el footer de cualquier
 * sitio con publicidad/afiliación.
 */
require __DIR__ . '/smartphonematch-api/config.php';
require __DIR__ . '/lang/i18n.php';
require __DIR__ . '/legal/legal-config.php';

$lang = resolve_lang();
function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }

$title = t('legal.about_title', $lang) . ' — SmartPhoneMatch';
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e(t('about.intro', $lang)) ?>">
<?php render_hreflang($lang, 'about'); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<?php render_head_common(); ?>
</head>
<body>
<?php render_chrome_open($lang, null); ?>

<main>
  <div class="view">
    <p class="eyebrow"><?= e(t('about.eyebrow', $lang)) ?></p>
    <h1><?= e(t('about.heading', $lang)) ?></h1>
    <p><?= e(t('about.intro', $lang)) ?></p>

    <h2><?= e(t('about.who_heading', $lang)) ?></h2>
    <p><?= t('about.who_text', $lang, [
      'owner_name' => e(SITE_OWNER_NAME),
      'legal_link' => e(url_for($lang, 'legal')),
    ]) ?></p>

    <h2><?= e(t('about.how_heading', $lang)) ?></h2>
    <p><?= e(t('about.how_text', $lang)) ?></p>

    <h2><?= e(t('about.data_heading', $lang)) ?></h2>
    <p><?= e(t('about.data_text', $lang)) ?></p>

    <h2><?= e(t('about.contact_heading', $lang)) ?></h2>
    <p><?= t('about.contact_text', $lang, ['owner_email' => e(SITE_OWNER_EMAIL)]) ?></p>
  </div>
</main>

<?php render_footer($lang); ?>
</body>
</html>
