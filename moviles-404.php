<?php
require_once __DIR__ . '/lang/i18n.php';
$lang = $lang ?? resolve_lang();
$home = url_for($lang, 'home');
function e404($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
?>
<!DOCTYPE html>
<html lang="<?= e404($lang) ?>">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= e404(t('404.title', $lang)) ?> — SmartPhoneMatch</title>
<meta name="robots" content="noindex">
<link rel="stylesheet" href="/assets/site.css">
</head>
<body>
<header class="nav">
  <a href="<?= e404($home) ?>" class="logo"><span class="dot"></span>SmartPhoneMatch</a>
</header>
<main>
  <div class="view empty">
    <?= e404(t('404.text', $lang)) ?><br><br>
    <a class="btn btn-primary" href="<?= e404(spa_url($lang, '/resultados')) ?>"><?= e404(t('phone.view_all', $lang)) ?></a>
  </div>
</main>
</body>
</html>
