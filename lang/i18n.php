<?php
/**
 * Núcleo de internacionalización — usado por todas las páginas PHP
 * renderizadas en servidor (moviles/, comparar/, ofertas/, sitemap, 404)
 * y por recommend.php. Toda la lógica de idioma vive aquí una sola vez;
 * las páginas solo llaman a t()/url_for()/render_nav() etc.
 */

const SPM_LANGS = ['es', 'en'];
const SPM_DEFAULT_LANG = 'en'; // cualquier idioma no soportado cae aquí
const SPM_LANG_COOKIE = 'spm_lang';

/**
 * MERCADO — concepto aparte del idioma, aunque hoy vayan 1 a 1 (es→ES,
 * en→US). Separarlos ahora es lo que permite mañana ofrecer, por ejemplo,
 * en→UK o es→MX sin tocar el router de idiomas ni las plantillas: solo
 * haría falta añadir el mercado a SPM_MARKETS y su entrada en
 * SPM_LANG_MARKETS/SPM_LANG_DEFAULT_MARKET (y, cuando se implemente, un
 * selector de mercado que ya podría usar ?market=/la cookie de abajo).
 * El mercado decide QUÉ RETAILERS Y PRECIOS se muestran (tabla
 * `retailers.market`) — nunca la URL ni las traducciones, que dependen
 * solo del idioma.
 */
const SPM_MARKETS = ['ES', 'US'];
// Qué mercados puede servir cada idioma (hoy uno solo cada uno).
const SPM_LANG_MARKETS = ['es' => ['ES'], 'en' => ['US']];
const SPM_LANG_DEFAULT_MARKET = ['es' => 'ES', 'en' => 'US'];
const SPM_MARKET_COOKIE = 'spm_market';

/**
 * Resuelve el mercado para el idioma actual. Mismo orden de prioridad que
 * el idioma (parámetro explícito -> cookie -> valor por defecto del
 * idioma), pero siempre restringido a los mercados que ese idioma puede
 * servir — así nunca se cuela, por ejemplo, mercado US en una página en
 * español.
 */
function resolve_market(string $lang): string {
    $allowed = SPM_LANG_MARKETS[$lang] ?? [SPM_DEFAULT_LANG];
    if (!empty($_GET['market']) && in_array($_GET['market'], $allowed, true)) {
        return $_GET['market'];
    }
    if (!empty($_COOKIE[SPM_MARKET_COOKIE]) && in_array($_COOKIE[SPM_MARKET_COOKIE], $allowed, true)) {
        return $_COOKIE[SPM_MARKET_COOKIE];
    }
    return SPM_LANG_DEFAULT_MARKET[$lang] ?? $allowed[0];
}

/**
 * Formatea un rango de precio para el mercado dado. ES sigue exactamente
 * igual que siempre (1.219–1.489 €, separador de miles con punto, símbolo
 * detrás). US usa el formato propio del mercado ($1,219–$1,489, separador
 * de miles con coma, símbolo delante) sobre el MISMO valor numérico del
 * catálogo — no hay conversión de divisa real (no tenemos precios de EE.
 * UU. verificados todavía), así que el precio para US se marca siempre
 * como no verificado (ver verified_badge más abajo) hasta que se cargue un
 * precio propio de ese mercado.
 */
const SPM_MARKET_CURRENCY = ['ES' => '€', 'US' => '$'];
function fmt_price(string $market, $min, $max): string {
    $symbol = SPM_MARKET_CURRENCY[$market] ?? '€';
    $fmtNum = fn($n) => $market === 'US'
        ? number_format((float)$n, 0, '.', ',')
        : number_format((float)$n, 0, ',', '.');
    if ((float)$min === (float)$max) {
        return $market === 'US' ? "{$symbol}{$fmtNum($min)}" : "{$fmtNum($min)} {$symbol}";
    }
    return $market === 'US'
        ? "{$symbol}{$fmtNum($min)}–{$symbol}{$fmtNum($max)}"
        : "{$fmtNum($min)}–{$fmtNum($max)} {$symbol}";
}

/**
 * Segmentos de ruta por idioma. Español mantiene las rutas originales
 * (compatibilidad); inglés usa sus propios segmentos legibles.
 */
const SPM_SEGMENTS = [
    'es' => ['mobiles' => 'moviles', 'brand' => 'marca', 'compare' => 'comparar', 'deals' => 'ofertas', 'budget_prefix' => 'mejores-moviles-', 'budget_suffix' => '-euros', 'privacy' => 'privacidad', 'legal' => 'aviso-legal', 'cookies' => 'cookies', 'about' => 'sobre-nosotros'],
    'en' => ['mobiles' => 'mobiles', 'brand' => 'brand', 'compare' => 'compare', 'deals' => 'deals', 'budget_prefix' => 'best-phones-', 'budget_suffix' => '-euros', 'privacy' => 'privacy', 'legal' => 'legal-notice', 'cookies' => 'cookies', 'about' => 'about'],
];

/**
 * Resuelve el idioma para la petición actual:
 * 1) ?lang= explícito en la URL (lo añade el router de .htaccess) — máxima prioridad,
 *    porque en URLs con prefijo /es|en/ la ruta es la fuente de verdad (así hreflang
 *    funciona de verdad: cada URL sirve siempre el mismo idioma).
 * 2) Cookie de elección manual guardada.
 * 3) Cabecera Accept-Language del navegador.
 * 4) SPM_DEFAULT_LANG.
 */
function resolve_lang(): string {
    if (!empty($_GET['lang']) && in_array($_GET['lang'], SPM_LANGS, true)) {
        return $_GET['lang'];
    }
    if (!empty($_COOKIE[SPM_LANG_COOKIE]) && in_array($_COOKIE[SPM_LANG_COOKIE], SPM_LANGS, true)) {
        return $_COOKIE[SPM_LANG_COOKIE];
    }
    $accept = $_SERVER['HTTP_ACCEPT_LANGUAGE'] ?? '';
    if (preg_match('/^\s*es/i', $accept)) return 'es';
    if (preg_match('/^\s*en/i', $accept)) return 'en';
    return SPM_DEFAULT_LANG;
}

/** Carga (con caché estática) el diccionario de un idioma. */
function load_dict(string $lang): array {
    static $cache = [];
    if (!isset($cache[$lang])) {
        $file = __DIR__ . "/$lang.php";
        $cache[$lang] = is_file($file) ? require $file : [];
    }
    return $cache[$lang];
}

/**
 * Traduce una clave. %variable% se sustituye por $vars['variable'].
 * Si falta la clave, devuelve la propia clave entre corchetes (visible
 * y fácil de detectar en QA, nunca una cadena vacía silenciosa).
 */
function t(string $key, string $lang, array $vars = []): string {
    $dict = load_dict($lang);
    $str = $dict[$key] ?? "[$key]";
    foreach ($vars as $k => $v) {
        $str = str_replace('%' . $k . '%', (string)$v, $str);
    }
    return $str;
}

/** Construye una URL localizada para el tipo de página indicado. */
function url_for(string $lang, string $type, array $params = []): string {
    $seg = SPM_SEGMENTS[$lang] ?? SPM_SEGMENTS[SPM_DEFAULT_LANG];
    switch ($type) {
        case 'home':    return "/$lang/";
        case 'mobiles': return "/$lang/{$seg['mobiles']}/";
        case 'mobile':  return "/$lang/{$seg['mobiles']}/" . rawurlencode($params['slug']);
        case 'brand':   return "/$lang/{$seg['mobiles']}/{$seg['brand']}/" . rawurlencode($params['slug']);
        case 'budget':  return "/$lang/{$seg['mobiles']}/{$seg['budget_prefix']}{$params['max']}{$seg['budget_suffix']}";
        case 'compare': return "/$lang/{$seg['compare']}/" . rawurlencode($params['a']) . '-vs-' . rawurlencode($params['b']);
        case 'deals':   return "/$lang/{$seg['deals']}/";
        case 'privacy': return "/$lang/{$seg['privacy']}/";
        case 'legal':   return "/$lang/{$seg['legal']}/";
        case 'cookies': return "/$lang/{$seg['cookies']}/";
        case 'about':   return "/$lang/{$seg['about']}/";
        default:        return "/$lang/";
    }
}

/**
 * URL de la SPA (cuestionario/resultados/comparador interactivo) para un
 * idioma dado. La SPA vive en la home de cada idioma (/es/, /en/) — mismo
 * archivo estático servido por el router, sin una ruta "/app/" aparte.
 */
function spa_url(string $lang, string $hash = ''): string {
    return url_for($lang, 'home') . ($hash ? '#' . ltrim($hash, '#') : '');
}

/**
 * Dado el tipo de página actual + sus parámetros, calcula la URL equivalente
 * en el OTRO idioma — para el <link rel="alternate" hreflang> y el selector
 * de idioma (cambiar de idioma sin perder la página en la que estás).
 */
function alternate_urls(string $type, array $params = []): array {
    $out = [];
    foreach (SPM_LANGS as $l) $out[$l] = url_for($l, $type, $params);
    return $out;
}

function current_scheme_host(): array {
    $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
    return [$scheme, $host];
}

/** Emite <link rel="canonical"> + hreflang para todos los idiomas + x-default. */
function render_hreflang(string $lang, string $type, array $params = []): void {
    [$scheme, $host] = current_scheme_host();
    $alt = alternate_urls($type, $params);
    $canonical = "$scheme://$host" . $alt[$lang];
    echo '<link rel="canonical" href="' . htmlspecialchars($canonical, ENT_QUOTES) . "\">\n";
    foreach ($alt as $l => $path) {
        echo '<link rel="alternate" hreflang="' . $l . '" href="' . htmlspecialchars("$scheme://$host$path", ENT_QUOTES) . "\">\n";
    }
    // x-default apunta a inglés: es el idioma de reserva para tráfico que no coincide con ninguno soportado.
    echo '<link rel="alternate" hreflang="x-default" href="' . htmlspecialchars("$scheme://$host{$alt[SPM_DEFAULT_LANG]}", ENT_QUOTES) . "\">\n";
}

/** Cabecera común: charset, viewport, favicon, fuentes. Idéntica en todas las páginas. */
function render_head_common(): void {
    ?>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script>
// Aplica el tema guardado ANTES de pintar la página — igual que la SPA —
// para que ir de la SPA a una página SSR (o viceversa) no cambie el tema
// ni provoque parpadeo. Misma clave de localStorage ("spm-theme") que usa
// smartphonematch-demo.html.
(function(){
  try{
    var t = localStorage.getItem('spm-theme');
    if(!t){ t = matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark'; }
    if(t === 'light') document.documentElement.setAttribute('data-theme','light');
  }catch(e){}
})();
</script>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Cdefs%3E%3ClinearGradient id='g' x1='0' y1='0' x2='1' y2='1'%3E%3Cstop offset='0' stop-color='%2345E0C7'/%3E%3Cstop offset='1' stop-color='%239B7CFF'/%3E%3C/linearGradient%3E%3C/defs%3E%3Crect width='100' height='100' rx='24' fill='%230E1120'/%3E%3Ccircle cx='50' cy='50' r='30' fill='url(%23g)'/%3E%3C/svg%3E">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/site.css">
<?php
}

/**
 * Barra de aviso de precios + cabecera de navegación, con el selector de
 * idioma y el enlace activo correctamente marcado (aria-current + clase
 * .active) — esto es lo que corrige el bug de "Ofertas desaparece del
 * navbar": antes cada página copiaba su propio <nav> a mano y alguna
 * (ofertas/index.php) directamente se dejaba el enlace fuera. Ahora todas
 * llaman a esta única función.
 *
 * $active uno de: 'home' | 'mobiles' | 'compare' | 'deals' | null
 */
function render_chrome_open(string $lang, ?string $active = null): void {
    $home = url_for($lang, 'home');
    $items = [
        'mobiles' => ['label' => t('nav.mobiles', $lang), 'href' => spa_url($lang, '/resultados')],
        'compare' => ['label' => t('nav.compare', $lang), 'href' => spa_url($lang, '/comparar')],
        'deals'   => ['label' => t('nav.deals', $lang), 'href' => url_for($lang, 'deals')],
    ];
    ?>
<div class="notice-banner"><?= t('banner.notice', $lang) ?></div>

<header class="nav">
  <a href="<?= htmlspecialchars($home, ENT_QUOTES) ?>" class="logo"><span class="dot"></span>SmartPhoneMatch</a>
  <div class="nav-right">
    <nav class="links">
      <a href="<?= htmlspecialchars(spa_url($lang, '/quiz'), ENT_QUOTES) ?>"><?= htmlspecialchars(t('nav.find', $lang)) ?></a>
      <?php foreach ($items as $key => $it): $isActive = $active === $key; ?>
      <a href="<?= htmlspecialchars($it['href'], ENT_QUOTES) ?>" class="<?= $isActive ? 'active' : '' ?>" <?= $isActive ? 'aria-current="page"' : '' ?>><?= htmlspecialchars($it['label']) ?></a>
      <?php endforeach; ?>
    </nav>
    <?php render_lang_switcher($lang); ?>
    <button type="button" class="theme-toggle" id="theme-toggle" aria-label="<?= htmlspecialchars(t('theme.to_light', $lang)) ?>" aria-pressed="false">
      <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4.2"/><path d="M12 2.5v2.4M12 19.1v2.4M4.2 4.2l1.7 1.7M18.1 18.1l1.7 1.7M2.5 12h2.4M19.1 12h2.4M4.2 19.8l1.7-1.7M18.1 5.9l1.7-1.7"/></svg>
      <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 14.5A8.5 8.5 0 1 1 9.5 4a6.8 6.8 0 0 0 10.5 10.5z"/></svg>
    </button>
  </div>
</header>
<?php
}

/** Selector de idioma 🇬🇧/🇪🇸 — reenvía a set-lang.php, que guarda la cookie y redirige a la misma página en el otro idioma. */
function render_lang_switcher(string $lang, string $returnType = 'home', array $returnParams = []): void {
    $other = $lang === 'es' ? 'en' : 'es';
    $target = url_for($other, $returnType, $returnParams);
    $flag = $other === 'es' ? '🇪🇸' : '🇬🇧';
    $label = t('lang.' . $other, $lang);
    ?>
<a class="lang-switch" href="/set-lang.php?lang=<?= $other ?>&amp;to=<?= urlencode($target) ?>" aria-label="<?= htmlspecialchars(t('lang.switch_label', $lang)) ?>: <?= htmlspecialchars($label) ?>">
  <span class="lang-flag" aria-hidden="true"><?= $flag ?></span><span class="lang-code"><?= strtoupper($other) ?></span>
</a>
<?php
}

function render_footer(string $lang): void {
    ?>
<footer>
  <span>© <?= date('Y') ?> SmartPhoneMatch</span>
  <span class="faint"><?= htmlspecialchars(t('footer.disclosure', $lang)) ?></span>
  <nav class="footer-legal">
    <a href="<?= htmlspecialchars(url_for($lang, 'about'), ENT_QUOTES) ?>"><?= htmlspecialchars(t('footer.legal_about', $lang)) ?></a>
    <a href="<?= htmlspecialchars(url_for($lang, 'privacy'), ENT_QUOTES) ?>"><?= htmlspecialchars(t('footer.legal_privacy', $lang)) ?></a>
    <a href="<?= htmlspecialchars(url_for($lang, 'legal'), ENT_QUOTES) ?>"><?= htmlspecialchars(t('footer.legal_terms', $lang)) ?></a>
    <a href="<?= htmlspecialchars(url_for($lang, 'cookies'), ENT_QUOTES) ?>"><?= htmlspecialchars(t('footer.legal_cookies', $lang)) ?></a>
  </nav>
</footer>
<?php render_consent_banner($lang); ?>
<script>
// Conecta el botón de tema pintado por render_chrome_open() — misma lógica
// y misma clave de localStorage ("spm-theme") que smartphonematch-demo.html,
// para que el tema se comporte igual se navegue por la SPA o por estas
// páginas SSR.
(function(){
  var LABEL_LIGHT = <?= json_encode(t('theme.to_light', $lang)) ?>;
  var LABEL_DARK = <?= json_encode(t('theme.to_dark', $lang)) ?>;
  function current(){ return document.documentElement.getAttribute('data-theme') === 'light' ? 'light' : 'dark'; }
  function apply(theme, btn){
    if(theme === 'light') document.documentElement.setAttribute('data-theme','light');
    else document.documentElement.removeAttribute('data-theme');
    if(btn){
      btn.setAttribute('aria-pressed', theme === 'light' ? 'true' : 'false');
      btn.setAttribute('aria-label', theme === 'light' ? LABEL_DARK : LABEL_LIGHT);
    }
  }
  var btn = document.getElementById('theme-toggle');
  if(!btn) return;
  apply(current(), btn);
  btn.addEventListener('click', function(){
    var next = current() === 'light' ? 'dark' : 'light';
    try { localStorage.setItem('spm-theme', next); } catch(e){}
    apply(next, btn);
  });
})();
</script>
<?php
}

/**
 * Banner de consentimiento de cookies (RGPD/LSSI). Solo se muestra si
 * todavía no hay una cookie spm_consent guardada — la lógica de mostrar/
 * ocultar y guardar la decisión vive en assets/consent.js (compartido con
 * la SPA, para que "aceptar" en una página SSR también valga en la SPA y
 * viceversa). Aquí solo se pinta el marcado y se traducen los textos.
 */
function render_consent_banner(string $lang): void {
    ?>
<div id="spm-consent-banner" class="consent-banner" role="dialog" aria-live="polite" aria-label="<?= htmlspecialchars(t('consent.aria_label', $lang)) ?>" hidden>
  <p><?= t('consent.text', $lang, ['link' => htmlspecialchars(url_for($lang, 'cookies'), ENT_QUOTES)]) ?></p>
  <div class="consent-actions">
    <button type="button" class="btn" id="spm-consent-reject"><?= htmlspecialchars(t('consent.reject', $lang)) ?></button>
    <button type="button" class="btn btn-primary" id="spm-consent-accept"><?= htmlspecialchars(t('consent.accept', $lang)) ?></button>
  </div>
</div>
<script src="/assets/consent.js" defer></script>
<?php
}
