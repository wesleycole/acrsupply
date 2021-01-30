// modules are defined as an array
// [ module function, map of requires ]
//
// map of requires is short require name -> numeric require
//
// anything defined in a previous bundle is accessed via the
// orig method which is the require for previous bundles
parcelRequire = (function (modules, cache, entry, globalName) {
  // Save the require from previous bundle to this closure if any
  var previousRequire = typeof parcelRequire === 'function' && parcelRequire;
  var nodeRequire = typeof require === 'function' && require;

  function newRequire(name, jumped) {
    if (!cache[name]) {
      if (!modules[name]) {
        // if we cannot find the module within our internal map or
        // cache jump to the current global require ie. the last bundle
        // that was added to the page.
        var currentRequire = typeof parcelRequire === 'function' && parcelRequire;
        if (!jumped && currentRequire) {
          return currentRequire(name, true);
        }

        // If there are other bundles on this page the require from the
        // previous one is saved to 'previousRequire'. Repeat this as
        // many times as there are bundles until the module is found or
        // we exhaust the require chain.
        if (previousRequire) {
          return previousRequire(name, true);
        }

        // Try the node require function if it exists.
        if (nodeRequire && typeof name === 'string') {
          return nodeRequire(name);
        }

        var err = new Error('Cannot find module \'' + name + '\'');
        err.code = 'MODULE_NOT_FOUND';
        throw err;
      }

      localRequire.resolve = resolve;
      localRequire.cache = {};

      var module = cache[name] = new newRequire.Module(name);

      modules[name][0].call(module.exports, localRequire, module, module.exports, this);
    }

    return cache[name].exports;

    function localRequire(x){
      return newRequire(localRequire.resolve(x));
    }

    function resolve(x){
      return modules[name][1][x] || x;
    }
  }

  function Module(moduleName) {
    this.id = moduleName;
    this.bundle = newRequire;
    this.exports = {};
  }

  newRequire.isParcelRequire = true;
  newRequire.Module = Module;
  newRequire.modules = modules;
  newRequire.cache = cache;
  newRequire.parent = previousRequire;
  newRequire.register = function (id, exports) {
    modules[id] = [function (require, module) {
      module.exports = exports;
    }, {}];
  };

  var error;
  for (var i = 0; i < entry.length; i++) {
    try {
      newRequire(entry[i]);
    } catch (e) {
      // Save first error but execute all entries
      if (!error) {
        error = e;
      }
    }
  }

  if (entry.length) {
    // Expose entry point to Node, AMD or browser globals
    // Based on https://github.com/ForbesLindesay/umd/blob/master/template.js
    var mainExports = newRequire(entry[entry.length - 1]);

    // CommonJS
    if (typeof exports === "object" && typeof module !== "undefined") {
      module.exports = mainExports;

    // RequireJS
    } else if (typeof define === "function" && define.amd) {
     define(function () {
       return mainExports;
     });

    // <script>
    } else if (globalName) {
      this[globalName] = mainExports;
    }
  }

  // Override the current require with this new one
  parcelRequire = newRequire;

  if (error) {
    // throw error from earlier, _after updating parcelRequire_
    throw error;
  }

  return newRequire;
})({"../../../../node_modules/countup.js/dist/countUp.min.js":[function(require,module,exports) {
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.CountUp = void 0;

var __assign = void 0 && (void 0).__assign || function () {
  return (__assign = Object.assign || function (t) {
    for (var i, a = 1, s = arguments.length; a < s; a++) for (var n in i = arguments[a]) Object.prototype.hasOwnProperty.call(i, n) && (t[n] = i[n]);

    return t;
  }).apply(this, arguments);
},
    CountUp = function () {
  function t(t, i, a) {
    var s = this;
    this.target = t, this.endVal = i, this.options = a, this.version = "2.0.7", this.defaults = {
      startVal: 0,
      decimalPlaces: 0,
      duration: 2,
      useEasing: !0,
      useGrouping: !0,
      smartEasingThreshold: 999,
      smartEasingAmount: 333,
      separator: ",",
      decimal: ".",
      prefix: "",
      suffix: ""
    }, this.finalEndVal = null, this.useEasing = !0, this.countDown = !1, this.error = "", this.startVal = 0, this.paused = !0, this.count = function (t) {
      s.startTime || (s.startTime = t);
      var i = t - s.startTime;
      s.remaining = s.duration - i, s.useEasing ? s.countDown ? s.frameVal = s.startVal - s.easingFn(i, 0, s.startVal - s.endVal, s.duration) : s.frameVal = s.easingFn(i, s.startVal, s.endVal - s.startVal, s.duration) : s.countDown ? s.frameVal = s.startVal - (s.startVal - s.endVal) * (i / s.duration) : s.frameVal = s.startVal + (s.endVal - s.startVal) * (i / s.duration), s.countDown ? s.frameVal = s.frameVal < s.endVal ? s.endVal : s.frameVal : s.frameVal = s.frameVal > s.endVal ? s.endVal : s.frameVal, s.frameVal = Number(s.frameVal.toFixed(s.options.decimalPlaces)), s.printValue(s.frameVal), i < s.duration ? s.rAF = requestAnimationFrame(s.count) : null !== s.finalEndVal ? s.update(s.finalEndVal) : s.callback && s.callback();
    }, this.formatNumber = function (t) {
      var i,
          a,
          n,
          e,
          r,
          o = t < 0 ? "-" : "";

      if (i = Math.abs(t).toFixed(s.options.decimalPlaces), n = (a = (i += "").split("."))[0], e = a.length > 1 ? s.options.decimal + a[1] : "", s.options.useGrouping) {
        r = "";

        for (var l = 0, h = n.length; l < h; ++l) 0 !== l && l % 3 == 0 && (r = s.options.separator + r), r = n[h - l - 1] + r;

        n = r;
      }

      return s.options.numerals && s.options.numerals.length && (n = n.replace(/[0-9]/g, function (t) {
        return s.options.numerals[+t];
      }), e = e.replace(/[0-9]/g, function (t) {
        return s.options.numerals[+t];
      })), o + s.options.prefix + n + e + s.options.suffix;
    }, this.easeOutExpo = function (t, i, a, s) {
      return a * (1 - Math.pow(2, -10 * t / s)) * 1024 / 1023 + i;
    }, this.options = __assign(__assign({}, this.defaults), a), this.formattingFn = this.options.formattingFn ? this.options.formattingFn : this.formatNumber, this.easingFn = this.options.easingFn ? this.options.easingFn : this.easeOutExpo, this.startVal = this.validateValue(this.options.startVal), this.frameVal = this.startVal, this.endVal = this.validateValue(i), this.options.decimalPlaces = Math.max(this.options.decimalPlaces), this.resetDuration(), this.options.separator = String(this.options.separator), this.useEasing = this.options.useEasing, "" === this.options.separator && (this.options.useGrouping = !1), this.el = "string" == typeof t ? document.getElementById(t) : t, this.el ? this.printValue(this.startVal) : this.error = "[CountUp] target is null or undefined";
  }

  return t.prototype.determineDirectionAndSmartEasing = function () {
    var t = this.finalEndVal ? this.finalEndVal : this.endVal;
    this.countDown = this.startVal > t;
    var i = t - this.startVal;

    if (Math.abs(i) > this.options.smartEasingThreshold) {
      this.finalEndVal = t;
      var a = this.countDown ? 1 : -1;
      this.endVal = t + a * this.options.smartEasingAmount, this.duration = this.duration / 2;
    } else this.endVal = t, this.finalEndVal = null;

    this.finalEndVal ? this.useEasing = !1 : this.useEasing = this.options.useEasing;
  }, t.prototype.start = function (t) {
    this.error || (this.callback = t, this.duration > 0 ? (this.determineDirectionAndSmartEasing(), this.paused = !1, this.rAF = requestAnimationFrame(this.count)) : this.printValue(this.endVal));
  }, t.prototype.pauseResume = function () {
    this.paused ? (this.startTime = null, this.duration = this.remaining, this.startVal = this.frameVal, this.determineDirectionAndSmartEasing(), this.rAF = requestAnimationFrame(this.count)) : cancelAnimationFrame(this.rAF), this.paused = !this.paused;
  }, t.prototype.reset = function () {
    cancelAnimationFrame(this.rAF), this.paused = !0, this.resetDuration(), this.startVal = this.validateValue(this.options.startVal), this.frameVal = this.startVal, this.printValue(this.startVal);
  }, t.prototype.update = function (t) {
    cancelAnimationFrame(this.rAF), this.startTime = null, this.endVal = this.validateValue(t), this.endVal !== this.frameVal && (this.startVal = this.frameVal, this.finalEndVal || this.resetDuration(), this.finalEndVal = null, this.determineDirectionAndSmartEasing(), this.rAF = requestAnimationFrame(this.count));
  }, t.prototype.printValue = function (t) {
    var i = this.formattingFn(t);
    "INPUT" === this.el.tagName ? this.el.value = i : "text" === this.el.tagName || "tspan" === this.el.tagName ? this.el.textContent = i : this.el.innerHTML = i;
  }, t.prototype.ensureNumber = function (t) {
    return "number" == typeof t && !isNaN(t);
  }, t.prototype.validateValue = function (t) {
    var i = Number(t);
    return this.ensureNumber(i) ? i : (this.error = "[CountUp] invalid start or end value: " + t, null);
  }, t.prototype.resetDuration = function () {
    this.startTime = null, this.duration = 1e3 * Number(this.options.duration), this.remaining = this.duration;
  }, t;
}();

exports.CountUp = CountUp;
},{}],"touchpoints.js":[function(require,module,exports) {
"use strict";

var _countup = require("countup.js");

(function () {
  fetch("https://v2-api.sheety.co/011deb83da15c598545e44f2f0c4609d/acrSupplyTouchPoints/totals").then(function (response) {
    return response.json();
  }).then(function (_ref) {
    var totals = _ref.totals;
    var dataPoint = totals[0];
    var pamphlets = dataPoint.pamphlets,
        theStory = dataPoint.theStory,
        volunteerHours = dataPoint.volunteerHours,
        volunteerPeopleImpact = dataPoint.volunteerPeopleImpact;
    var pamphletsCount = new _countup.CountUp("pamphletsTouchpoint", pamphlets);
    pamphletsCount.start();
    var theStoryCount = new _countup.CountUp("theStoryTouchpoint", theStory);
    theStoryCount.start();
    var volunteerHoursCount = new _countup.CountUp("volunteerHoursTouchpoint", volunteerHours);
    volunteerHoursCount.start();
    var volunteerPeopleImpactCount = new _countup.CountUp("volunteerPeopleImpactedTouchpoint", volunteerPeopleImpact);
    volunteerPeopleImpactCount.start();
  });
})();
},{"countup.js":"../../../../node_modules/countup.js/dist/countUp.min.js"}],"../../../../node_modules/parcel-bundler/src/builtins/hmr-runtime.js":[function(require,module,exports) {
var global = arguments[3];
var OVERLAY_ID = '__parcel__error__overlay__';
var OldModule = module.bundle.Module;

function Module(moduleName) {
  OldModule.call(this, moduleName);
  this.hot = {
    data: module.bundle.hotData,
    _acceptCallbacks: [],
    _disposeCallbacks: [],
    accept: function (fn) {
      this._acceptCallbacks.push(fn || function () {});
    },
    dispose: function (fn) {
      this._disposeCallbacks.push(fn);
    }
  };
  module.bundle.hotData = null;
}

module.bundle.Module = Module;
var checkedAssets, assetsToAccept;
var parent = module.bundle.parent;

if ((!parent || !parent.isParcelRequire) && typeof WebSocket !== 'undefined') {
  var hostname = "" || location.hostname;
  var protocol = location.protocol === 'https:' ? 'wss' : 'ws';
  var ws = new WebSocket(protocol + '://' + hostname + ':' + "63921" + '/');

  ws.onmessage = function (event) {
    checkedAssets = {};
    assetsToAccept = [];
    var data = JSON.parse(event.data);

    if (data.type === 'update') {
      var handled = false;
      data.assets.forEach(function (asset) {
        if (!asset.isNew) {
          var didAccept = hmrAcceptCheck(global.parcelRequire, asset.id);

          if (didAccept) {
            handled = true;
          }
        }
      }); // Enable HMR for CSS by default.

      handled = handled || data.assets.every(function (asset) {
        return asset.type === 'css' && asset.generated.js;
      });

      if (handled) {
        console.clear();
        data.assets.forEach(function (asset) {
          hmrApply(global.parcelRequire, asset);
        });
        assetsToAccept.forEach(function (v) {
          hmrAcceptRun(v[0], v[1]);
        });
      } else if (location.reload) {
        // `location` global exists in a web worker context but lacks `.reload()` function.
        location.reload();
      }
    }

    if (data.type === 'reload') {
      ws.close();

      ws.onclose = function () {
        location.reload();
      };
    }

    if (data.type === 'error-resolved') {
      console.log('[parcel] ✨ Error resolved');
      removeErrorOverlay();
    }

    if (data.type === 'error') {
      console.error('[parcel] 🚨  ' + data.error.message + '\n' + data.error.stack);
      removeErrorOverlay();
      var overlay = createErrorOverlay(data);
      document.body.appendChild(overlay);
    }
  };
}

function removeErrorOverlay() {
  var overlay = document.getElementById(OVERLAY_ID);

  if (overlay) {
    overlay.remove();
  }
}

function createErrorOverlay(data) {
  var overlay = document.createElement('div');
  overlay.id = OVERLAY_ID; // html encode message and stack trace

  var message = document.createElement('div');
  var stackTrace = document.createElement('pre');
  message.innerText = data.error.message;
  stackTrace.innerText = data.error.stack;
  overlay.innerHTML = '<div style="background: black; font-size: 16px; color: white; position: fixed; height: 100%; width: 100%; top: 0px; left: 0px; padding: 30px; opacity: 0.85; font-family: Menlo, Consolas, monospace; z-index: 9999;">' + '<span style="background: red; padding: 2px 4px; border-radius: 2px;">ERROR</span>' + '<span style="top: 2px; margin-left: 5px; position: relative;">🚨</span>' + '<div style="font-size: 18px; font-weight: bold; margin-top: 20px;">' + message.innerHTML + '</div>' + '<pre>' + stackTrace.innerHTML + '</pre>' + '</div>';
  return overlay;
}

function getParents(bundle, id) {
  var modules = bundle.modules;

  if (!modules) {
    return [];
  }

  var parents = [];
  var k, d, dep;

  for (k in modules) {
    for (d in modules[k][1]) {
      dep = modules[k][1][d];

      if (dep === id || Array.isArray(dep) && dep[dep.length - 1] === id) {
        parents.push(k);
      }
    }
  }

  if (bundle.parent) {
    parents = parents.concat(getParents(bundle.parent, id));
  }

  return parents;
}

function hmrApply(bundle, asset) {
  var modules = bundle.modules;

  if (!modules) {
    return;
  }

  if (modules[asset.id] || !bundle.parent) {
    var fn = new Function('require', 'module', 'exports', asset.generated.js);
    asset.isNew = !modules[asset.id];
    modules[asset.id] = [fn, asset.deps];
  } else if (bundle.parent) {
    hmrApply(bundle.parent, asset);
  }
}

function hmrAcceptCheck(bundle, id) {
  var modules = bundle.modules;

  if (!modules) {
    return;
  }

  if (!modules[id] && bundle.parent) {
    return hmrAcceptCheck(bundle.parent, id);
  }

  if (checkedAssets[id]) {
    return;
  }

  checkedAssets[id] = true;
  var cached = bundle.cache[id];
  assetsToAccept.push([bundle, id]);

  if (cached && cached.hot && cached.hot._acceptCallbacks.length) {
    return true;
  }

  return getParents(global.parcelRequire, id).some(function (id) {
    return hmrAcceptCheck(global.parcelRequire, id);
  });
}

function hmrAcceptRun(bundle, id) {
  var cached = bundle.cache[id];
  bundle.hotData = {};

  if (cached) {
    cached.hot.data = bundle.hotData;
  }

  if (cached && cached.hot && cached.hot._disposeCallbacks.length) {
    cached.hot._disposeCallbacks.forEach(function (cb) {
      cb(bundle.hotData);
    });
  }

  delete bundle.cache[id];
  bundle(id);
  cached = bundle.cache[id];

  if (cached && cached.hot && cached.hot._acceptCallbacks.length) {
    cached.hot._acceptCallbacks.forEach(function (cb) {
      cb();
    });

    return true;
  }
}
},{}]},{},["../../../../node_modules/parcel-bundler/src/builtins/hmr-runtime.js","touchpoints.js"], null)
//# sourceMappingURL=/touchpoints.js.map