/**
 * ap.js — Zurai Hub v4.0.0
 * Executor detection · DOM gating · loader render
 *
 * Loader one-liner fetches loader-api.html, extracts the Lua
 * source between <!--ZURAI_SRC ... ZURAI_SRC--> and runs it.
 */
;(function () {
  'use strict';

  /* ── Executor signatures (32) ─────────────────────────────── */
  var SIGS = [
    'syn','http_request','request','fluxus','oxygen','electron',
    'wave','krnl','proto','xeno','gethui','hookfunction','newcclosure',
    'clonefunction','getupvalues','is_sirhurt_caller','pebc_script_sig',
    'identifyexecutor','getexecutorname','KRNL_LOADED','CARBON_LOADED',
    'is_exploit_closure','get_nil_instances','getgc','getsenv',
    'Drawing','isluau','ExecuteScript','Synapse','EXECUTOR',
    'rconsoleprint','rconsolename','rconsolewarn',
  ];

  /* ── Detection ────────────────────────────────────────────── */
  function detect() {
    var ua = navigator.userAgent || '';
    if (ua.indexOf('RobloxApp') !== -1 || ua.indexOf('Roblox/') !== -1) return true;
    for (var i = 0; i < SIGS.length; i++) {
      try { if (typeof window[SIGS[i]] !== 'undefined') return true; }
      catch (_) { return true; }
    }
    try {
      var c = document.createElement('canvas');
      var gl = c.getContext('webgl') || c.getContext('experimental-webgl');
      if (gl && (gl.getParameter(gl.RENDERER) || '').toLowerCase().indexOf('roblox') !== -1) return true;
    } catch (_) {}
    return false;
  }

  var IS_EXEC = detect();

  /* ── Loader script (shown to executors only) ──────────────── */
  var LOADER = 'loadstring(game:HttpGet("https://zurai02.github.io/zurai-hub/loader-api.html"))()';

  /* ── Gating ───────────────────────────────────────────────── */
  function applyGating() {
    document.querySelectorAll('[data-exec-only]').forEach(function (el) { el.hidden = !IS_EXEC; });
    document.querySelectorAll('[data-browser-only]').forEach(function (el) { el.hidden = IS_EXEC; });
    var badge = document.getElementById('envBadge');
    if (badge) {
      if (IS_EXEC) {
        badge.innerHTML = '<span class="env-dot exec"></span>&#10003; Executor';
        badge.className = 'chip cg';
      } else {
        badge.innerHTML = '<span class="env-dot browser"></span>&#10007; Browser';
        badge.className = 'chip cr';
      }
    }
  }

  /* ── Render loader pre + copy button ─────────────────────── */
  function renderLoader() {
    var pre = document.getElementById('loaderPre');
    if (pre) pre.textContent = IS_EXEC ? LOADER : '';

    var btn = document.getElementById('loaderCopyBtn');
    if (!btn) return;
    btn.addEventListener('click', function () {
      navigator.clipboard.writeText(LOADER).then(function () {
        btn.textContent = 'Copied!';
        setTimeout(function () { btn.textContent = 'Copy'; }, 1800);
      }).catch(function () {
        if (pre) {
          var r = document.createRange();
          r.selectNodeContents(pre);
          var s = window.getSelection();
          if (s) { s.removeAllRanges(); s.addRange(r); }
        }
        btn.textContent = 'Selected';
        setTimeout(function () { btn.textContent = 'Copy'; }, 1800);
      });
    });
  }

  /* ── Scroll fade-in via Intersection Observer ─────────────── */
  function initScrollAnimations() {
    if (!window.IntersectionObserver) return;
    var els = document.querySelectorAll('.fade-in-up');
    var obs = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) {
          e.target.classList.add('visible');
          obs.unobserve(e.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    els.forEach(function (el) { obs.observe(el); });
  }

  /* ── Auto-init ────────────────────────────────────────────── */
  function init() {
    applyGating();
    renderLoader();
    initScrollAnimations();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  /* ── Public (optional external use) ──────────────────────── */
  window.Zurai = { isExecutor: IS_EXEC, loaderCode: IS_EXEC ? LOADER : null };

})();
