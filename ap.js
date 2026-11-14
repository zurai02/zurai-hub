/**
 * ap.js — Zurai Hub v4.0.0
 * Executor detection · DOM gating · loader render
 *
 * The generated one-liner reliably fetches the hosted loader page and executes it.
 */
;(function () {
  'use strict';

  var SIGS = [
    'syn','http_request','request','fluxus','oxygen','electron',
    'wave','krnl','proto','xeno','gethui','hookfunction','newcclosure',
    'clonefunction','getupvalues','is_sirhurt_caller','pebc_script_sig',
    'identifyexecutor','getexecutorname','KRNL_LOADED','CARBON_LOADED',
    'is_exploit_closure','get_nil_instances','getgc','getsenv',
    'Drawing','isluau','ExecuteScript','Synapse','EXECUTOR',
    'rconsoleprint','rconsolename','rconsolewarn'
  ];

  function detect() {
    var ua = navigator.userAgent || '';
    if (ua.indexOf('RobloxApp') !== -1 || ua.indexOf('Roblox/') !== -1) return true;

    for (var i = 0; i < SIGS.length; i += 1) {
      try {
        if (typeof window[SIGS[i]] !== 'undefined') return true;
      } catch (_) {
        return true;
      }
    }

    try {
      var c = document.createElement('canvas');
      var gl = c.getContext('webgl') || c.getContext('experimental-webgl');
      if (gl && (gl.getParameter(gl.RENDERER) || '').toLowerCase().indexOf('roblox') !== -1) {
        return true;
      }
    } catch (_) {}

    return false;
  }

  var IS_EXEC = detect();
  var LOADER = 'loadstring(game:HttpGet("https://zurai02.github.io/zurai-hub/loader-api.html", true))()';

  function eachNodeList(selector, cb) {
    var nodes = document.querySelectorAll(selector);
    Array.prototype.forEach.call(nodes, cb);
  }

  function applyGating() {
    eachNodeList('[data-exec-only]', function (el) {
      el.hidden = !IS_EXEC;
    });

    eachNodeList('[data-browser-only]', function (el) {
      el.hidden = IS_EXEC;
    });

    var badge = document.getElementById('envBadge');
    if (!badge) return;

    if (IS_EXEC) {
      badge.innerHTML = '<span class="env-dot exec"></span>&#10003; Executor';
      badge.className = 'chip cg';
    } else {
      badge.innerHTML = '<span class="env-dot browser"></span>&#10007; Browser';
      badge.className = 'chip cr';
    }
  }

  function renderLoader() {
    var pre = document.getElementById('loaderPre');
    var btn = document.getElementById('loaderCopyBtn');

    if (pre) {
      pre.textContent = IS_EXEC ? LOADER : '';
    }

    if (!btn) return;

    btn.addEventListener('click', function () {
      var copyText = function (text) {
        if (navigator.clipboard && navigator.clipboard.writeText) {
          return navigator.clipboard.writeText(text);
        }

        if (pre) {
          var range = document.createRange();
          range.selectNodeContents(pre);
          var selection = window.getSelection();
          if (selection) {
            selection.removeAllRanges();
            selection.addRange(range);
          }
        }

        return Promise.resolve();
      };

      copyText(LOADER).then(function () {
        btn.textContent = 'Copied!';
        setTimeout(function () { btn.textContent = 'Copy'; }, 1800);
      }).catch(function () {
        if (pre) {
          var range = document.createRange();
          range.selectNodeContents(pre);
          var selection = window.getSelection();
          if (selection) {
            selection.removeAllRanges();
            selection.addRange(range);
          }
        }

        btn.textContent = 'Selected';
        setTimeout(function () { btn.textContent = 'Copy'; }, 1800);
      });
    });
  }

  function initScrollAnimations() {
    if (!window.IntersectionObserver) return;

    var els = document.querySelectorAll('.fade-in-up');
    var obs = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          obs.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    Array.prototype.forEach.call(els, function (el) {
      obs.observe(el);
    });
  }

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

  window.Zurai = { isExecutor: IS_EXEC, loaderCode: IS_EXEC ? LOADER : null };
})();
