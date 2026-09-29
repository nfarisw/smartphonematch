/**
 * Consentimiento de cookies (RGPD/LSSI), compartido entre las páginas SSR
 * (lang/i18n.php -> render_consent_banner) y la SPA (smartphonematch-demo_1.html).
 * Una sola cookie "spm_consent" ('accepted'|'rejected') decide si se cargan
 * las cookies/scripts de analítica (GA4) y publicidad (AdSense) — nunca se
 * cargan por defecto. Sin elección guardada, se muestra el banner.
 */
(function () {
  var COOKIE_NAME = 'spm_consent';
  var MAX_AGE = 60 * 60 * 24 * 180; // 6 meses

  function readCookie(name) {
    var m = document.cookie.match('(?:^|; )' + name + '=([^;]*)');
    return m ? decodeURIComponent(m[1]) : '';
  }
  function writeCookie(name, value, maxAge) {
    var parts = [name + '=' + encodeURIComponent(value), 'path=/', 'samesite=lax'];
    if (maxAge === 0) parts.push('max-age=0');
    else parts.push('max-age=' + maxAge);
    document.cookie = parts.join('; ');
  }

  function notify(status) {
    try {
      window.dispatchEvent(new CustomEvent('spm:consent-changed', { detail: { status: status } }));
    } catch (e) {
      // navegadores muy antiguos sin soporte de CustomEvent: no hay listeners que avisar de todos modos
    }
  }

  function get() {
    var v = readCookie(COOKIE_NAME);
    return v === 'accepted' || v === 'rejected' ? v : '';
  }

  function set(status) {
    writeCookie(COOKIE_NAME, status, MAX_AGE);
    hideBanner();
    notify(status);
  }

  function accept() { set('accepted'); }
  function reject() { set('rejected'); }

  // Borra la decisión y vuelve a mostrar el banner — usado por el botón
  // "cambiar mi decisión" en la página de política de cookies.
  function forget() {
    writeCookie(COOKIE_NAME, '', 0);
    showBanner();
    notify('');
  }

  function showBanner() {
    var el = document.getElementById('spm-consent-banner');
    if (el) el.hidden = false;
  }
  function hideBanner() {
    var el = document.getElementById('spm-consent-banner');
    if (el) el.hidden = true;
  }

  function wireBanner() {
    var acceptBtn = document.getElementById('spm-consent-accept');
    var rejectBtn = document.getElementById('spm-consent-reject');
    if (acceptBtn) acceptBtn.addEventListener('click', accept);
    if (rejectBtn) rejectBtn.addEventListener('click', reject);
    if (!get()) showBanner();
  }

  window.spmConsent = { get: get, accept: accept, reject: reject, forget: forget };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', wireBanner);
  } else {
    wireBanner();
  }
})();
