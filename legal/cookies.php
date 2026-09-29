<?php
/**
 * /{lang}/cookies — qué cookies usamos y cómo cambiar la decisión de
 * consentimiento. El botón de "cambiar decisión" llama a
 * window.spmConsent.forget() (assets/consent.js), que borra la cookie
 * spm_consent y vuelve a mostrar el banner.
 */
require __DIR__ . '/../smartphonematch-api/config.php';
require __DIR__ . '/../lang/i18n.php';
require __DIR__ . '/legal-config.php';

$lang = resolve_lang();
function e($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }

$title = t('legal.cookies_title', $lang) . ' — SmartPhoneMatch';
$updated = date('Y-m-d');
$consentStatus = $_COOKIE['spm_consent'] ?? '';
$statusKey = $consentStatus === 'accepted' ? 'consent.current_accepted'
    : ($consentStatus === 'rejected' ? 'consent.current_rejected' : 'consent.current_none');
?><!DOCTYPE html>
<html lang="<?= e($lang) ?>">
<head>
<title><?= e($title) ?></title>
<meta name="description" content="<?= e(t('cookies.intro', $lang)) ?>">
<?php render_hreflang($lang, 'cookies'); ?>
<meta property="og:type" content="website">
<meta property="og:site_name" content="SmartPhoneMatch">
<meta property="og:title" content="<?= e($title) ?>">
<?php render_head_common(); ?>
</head>
<body>
<?php render_chrome_open($lang, null); ?>

<main>
  <div class="view">
    <p class="eyebrow"><?= e(t('cookies.eyebrow', $lang)) ?></p>
    <h1><?= e(t('cookies.heading', $lang)) ?></h1>
    <p class="faint"><?= t('cookies.updated', $lang, ['date' => e($updated)]) ?></p>
    <p><?= e(t('cookies.intro', $lang)) ?></p>

    <h2><?= e(t('cookies.table_necessary_heading', $lang)) ?></h2>
    <p><?= t('cookies.table_necessary_text', $lang) ?></p>

    <h2><?= e(t('cookies.table_analytics_heading', $lang)) ?></h2>
    <p><?= t('cookies.table_analytics_text', $lang) ?></p>

    <h2><?= e(t('cookies.table_ads_heading', $lang)) ?></h2>
    <p><?= t('cookies.table_ads_text', $lang) ?></p>

    <h2><?= e(t('cookies.manage_heading', $lang)) ?></h2>
    <p><?= e(t('cookies.manage_text', $lang)) ?></p>
    <p id="spm-consent-status" data-status="<?= e($consentStatus) ?>"><?= e(t($statusKey, $lang)) ?></p>
    <button type="button" class="btn btn-primary" id="spm-consent-change"><?= e(t('consent.change_button', $lang)) ?></button>
  </div>
</main>

<?php render_footer($lang); ?>
<script>
document.getElementById('spm-consent-change')?.addEventListener('click', function(){
  if (window.spmConsent && typeof window.spmConsent.forget === 'function') {
    window.spmConsent.forget();
  }
});
</script>
</body>
</html>
