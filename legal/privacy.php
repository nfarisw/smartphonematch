<?php
/**
 * /{lang}/privacidad|privacy — Política de Privacidad (RGPD). El texto
 * general vive en lang/{es,en}.php; los datos identificativos del titular
 * (nombre, dirección, email...) se inyectan desde legal-config.php para
 * no duplicarlos en cada página legal.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';
require __DIR__ . '/legal-config.php';

$lang = resolve_lang();
function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }

$title = t('legal.privacy_title', $lang) . ' — SmartPhoneMatch';
$updated = date('Y-m-d');
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e(t('privacy.intro', $lang)) ?>">
<?php render_hreflang($lang, 'privacy'); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<?php render_head_common(); ?>
</head>
<body>
<?php render_chrome_open($lang, null); ?>

<main>
  <div class="view">
    <p class="eyebrow"><?= e(t('privacy.eyebrow', $lang)) ?></p>
    <h1><?= e(t('privacy.heading', $lang)) ?></h1>
    <p class="faint"><?= t('privacy.updated', $lang, ['date' => e($updated)]) ?></p>
    <p><?= e(t('privacy.intro', $lang)) ?></p>

    <h2><?= e(t('privacy.controller_heading', $lang)) ?></h2>
    <p><?= t('privacy.controller_text', $lang, [
      'owner_name' => e(SITE_OWNER_NAME),
      'owner_address' => e(SITE_OWNER_ADDRESS),
      'owner_id' => e(SITE_OWNER_ID),
      'owner_email' => e(SITE_OWNER_EMAIL),
    ]) ?></p>

    <h2><?= e(t('privacy.data_heading', $lang)) ?></h2>
    <p><?= e(t('privacy.data_text', $lang)) ?></p>

    <h2><?= e(t('privacy.legal_basis_heading', $lang)) ?></h2>
    <p><?= t('privacy.legal_basis_text', $lang, ['cookies_link' => e(url_for($lang, 'cookies'))]) ?></p>

    <h2><?= e(t('privacy.retention_heading', $lang)) ?></h2>
    <p><?= e(t('privacy.retention_text', $lang)) ?></p>

    <h2><?= e(t('privacy.recipients_heading', $lang)) ?></h2>
    <p><?= t('privacy.recipients_text', $lang, ['hosting_provider' => e(SITE_HOSTING_PROVIDER)]) ?></p>

    <h2><?= e(t('privacy.rights_heading', $lang)) ?></h2>
    <p><?= t('privacy.rights_text', $lang, ['owner_email' => e(SITE_OWNER_EMAIL)]) ?></p>

    <h2><?= e(t('privacy.changes_heading', $lang)) ?></h2>
    <p><?= e(t('privacy.changes_text', $lang)) ?></p>
  </div>
</main>

<?php render_footer($lang); ?>
</body>
</html>
