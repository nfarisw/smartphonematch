<?php
/**
 * Handler del selector de idioma: guarda la elección manual en una cookie
 * de un año (se respeta siempre a partir de aquí) y redirige a la misma
 * página en el nuevo idioma.
 */
require __DIR__ . '/lang/i18n.php';

$lang = $_GET['lang'] ?? '';
if (!in_array($lang, SPM_LANGS, true)) $lang = SPM_DEFAULT_LANG;

setcookie(SPM_LANG_COOKIE, $lang, [
    'expires' => time() + 60 * 60 * 24 * 365,
    'path' => '/',
    'samesite' => 'Lax',
]);

$to = $_GET['to'] ?? '';
// Solo redirige a una ruta relativa dentro del propio sitio — nunca a una
// URL externa, para que este endpoint no pueda usarse como open redirect.
if ($to === '' || $to[0] !== '/' || str_starts_with($to, '//')) {
    $to = url_for($lang, 'home');
}
header('Location: ' . $to, true, 302);
exit;
