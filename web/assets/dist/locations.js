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
})({"stores.js":[function(require,module,exports) {
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.stores = void 0;
var stores = [{
  title: "ACR Supply Supply Distribution Center",
  address: "4040 S. Alston Ave, Durham, NC 27713",
  phone: "(919) 765 - 8081",
  position: {
    lat: 35.9187832,
    lng: -78.88911029999997
  }
}, {
  title: "ACR Supply Durham",
  address: "2719 Hillsborough Rd, Durham, NC 27705",
  phone: "(919) 286 - 2228",
  position: {
    lat: 36.01227739999999,
    lng: -78.9316978
  }
}, {
  title: "ACR Supply Carrboro",
  address: "101 Barnes St., Carrboro, NC 27510",
  phone: "(919) 929 - 2099",
  position: {
    lat: 35.9083652,
    lng: -79.07904189999999
  }
}, {
  title: "ACR Supply Burlington",
  address: "2352 W. Hanford Rd., Burlington, NC 27215",
  phone: "(336) 227 - 5000",
  position: {
    lat: 36.0605812,
    lng: -79.4372502
  }
}, {
  title: "ACR Supply Greensboro",
  address: "2201 Binford St., Greensboro, NC 27407",
  phone: "(336) 854 - 5800",
  position: {
    lat: 36.05970929999999,
    lng: -79.83266220000002
  }
}, {
  title: "ACR Supply Raleigh",
  address: "2416 Alwin Ct., Raleigh, NC 27604",
  phone: "(919) 861 - 2277",
  position: {
    lat: 35.81185060000001,
    lng: -78.61677179999998
  }
}, {
  title: "ACR Supply Wilmington",
  address: "3207 Burnt Mill Dr., Wilmington, NC 28403",
  phone: "(919) 442 - 3303",
  position: {
    lat: 34.229813,
    lng: -77.9023899
  }
}, {
  title: "ACR Supply Winston-Salem",
  address: "1735 Link Rd., Winston-Salem, NC 27103",
  phone: "(336) 831 - 0505",
  position: {
    lat: 36.0706427,
    lng: -80.26310219999999
  }
}, {
  title: "ACR Supply Winterville",
  address: "4125 Bayswater Rd., Winterville, NC 28590",
  phone: "(252) 754 - 2653",
  position: {
    lat: 35.553177,
    lng: -77.37196510000001
  }
}, {
  title: "Sales and Marketing Office",
  address: "200 Seneca Road, Greensboro NC, 27406",
  position: {
    lat: 36.0359615,
    lng: -79.7890453
  }
}];
exports.stores = stores;
},{}],"maps.js":[function(require,module,exports) {
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.addMapMarker = exports.initMap = void 0;

var _stores = require("./stores");

var initMap = function initMap(element) {
  var center = {
    lat: 35.684811,
    lng: -79.297692
  };
  var map = new google.maps.Map(element, {
    zoom: 7,
    center: center
  });

  _stores.stores.forEach(function (store) {
    return addMapMarker(store, map);
  });
};

exports.initMap = initMap;

var addMapMarker = function addMapMarker(store, map) {
  var position = store.position;
  var window = new google.maps.InfoWindow({
    content: generateWindowContent(store)
  });
  var marker = new google.maps.Marker({
    position: position,
    map: map
  });
  marker.addListener('click', function () {
    return displayWindow(window, map, marker);
  });
};

exports.addMapMarker = addMapMarker;

var displayWindow = function displayWindow(window, map, marker) {
  window.open(map, marker);
};

var generateWindowContent = function generateWindowContent(_ref) {
  var title = _ref.title,
      address = _ref.address,
      phone = _ref.phone;
  return "\n    <span style=\"font-weight: bold; display: block; margin-bottom: 5px;\">".concat(title, "</span>\n    <span>").concat(address, "</span><br />\n    <span>").concat(phone, "</span>\n  ");
};
},{"./stores":"stores.js"}],"locations.js":[function(require,module,exports) {
"use strict";

var _maps = require("./maps");

(function () {
  var mapElement = document.getElementById("locations-map");

  if (mapElement) {
    (0, _maps.initMap)(mapElement);
  }
})();
},{"./maps":"maps.js"}],"../../../../node_modules/parcel-bundler/src/builtins/hmr-runtime.js":[function(require,module,exports) {
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
  var ws = new WebSocket(protocol + '://' + hostname + ':' + "57286" + '/');

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
},{}]},{},["../../../../node_modules/parcel-bundler/src/builtins/hmr-runtime.js","locations.js"], null)
//# sourceMappingURL=/locations.js.map