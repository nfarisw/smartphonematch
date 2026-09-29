<?php
/**
 * Entrada neutra del sitio: detecta el idioma (cookie -> Accept-Language ->
 * inglés por defecto) y redirige a la home localizada correspondiente.
 * Sustituye a la página de bienvenida de XAMPP (redirigía a /dashboard/,
 * que no forma parte de este proyecto).
 */
require __DIR__ . '/lang/i18n.php';
header('Location: ' . url_for(resolve_lang(), 'home'), true, 302);
exit;
