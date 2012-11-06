(function(Crystal){
 (function() {
  var Application, Attributes, AudioWrapper, Bindings, Color, Keyboard, List, Logging, MVC, Model, ModelView, SPECIAL_KEYS, Song, Store, Types, Unit, Utils, css, i18n, key, method, methods, methods_element, methods_node, olds, prefixes, properties, types, value, _find, _parseName, _ref, _wrap,
    __hasProp = {}.hasOwnProperty,
    __slice = [].slice,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  MVC = {};

  Logging = {};

  Utils = {};

  Store = {};

  /*
  --------------- /home/gszikszai/git/crystal/source/types/array.coffee--------------
  */


  methods = {
    remove$: function(item) {
      var index;
      if ((index = this.indexOf(item)) !== -1) {
        return this.splice(index, 1);
      }
    },
    remove: function(item) {
      var b, index;
      b = this.dup();
      if ((index = b.indexOf(item)) !== -1) {
        b.splice(index, 1);
      }
      return b;
    },
    removeAll: function(item) {
      var b, index;
      b = this.dup();
      while ((index = b.indexOf(item)) !== -1) {
        b.splice(index, 1);
      }
      return b;
    },
    uniq: function() {
      var b;
      b = new this.__proto__.constructor;
      this.filter(function(item) {
        if (!b.include(item)) {
          return b.push(item);
        }
      });
      return b;
    },
    shuffle: function() {
      var shuffled;
      shuffled = [];
      this.forEach(function(value, index) {
        var rand;
        rand = Math.floor(Math.random() * (index + 1));
        shuffled[index] = shuffled[rand];
        return shuffled[rand] = value;
      });
      return shuffled;
    },
    compact: function() {
      return this.filter(function(item) {
        return !!item;
      });
    },
    dup: function(item) {
      return this.filter(function() {
        return true;
      });
    },
    pluck: function(property) {
      return this.map(function(item) {
        return item[property];
      });
    },
    include: function(item) {
      return this.indexOf(item) !== -1;
    }
  };

  for (key in methods) {
    method = methods[key];
    Object.defineProperty(Array.prototype, key, {
      value: method
    });
  }

  Object.defineProperties(Array.prototype, {
    sample: {
      get: function() {
        return this[Math.floor(Math.random() * this.length)];
      }
    },
    first: {
      get: function() {
        return this[0];
      }
    },
    last: {
      get: function() {
        return this[this.length - 1];
      }
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/types/object.coffee--------------
  */


  Object.defineProperties(Object.prototype, {
    toFormData: {
      value: function() {
        var ret, value;
        ret = new FormData();
        for (key in this) {
          if (!__hasProp.call(this, key)) continue;
          value = this[key];
          ret.append(key, value);
        }
        return ret;
      }
    },
    toQueryString: {
      value: function() {
        var value;
        return ((function() {
          var _results;
          _results = [];
          for (key in this) {
            if (!__hasProp.call(this, key)) continue;
            value = this[key];
            _results.push("" + key + "=" + (value.toString()));
          }
          return _results;
        }).call(this)).join("&");
      }
    }
  });

  Object.each = function(object, fn) {
    var value, _results;
    _results = [];
    for (key in object) {
      if (!__hasProp.call(object, key)) continue;
      value = object[key];
      _results.push(fn.call(object, key, value));
    }
    return _results;
  };

  Object.pluck = function(object, prop) {
    var value, _results;
    _results = [];
    for (key in object) {
      if (!__hasProp.call(object, key)) continue;
      value = object[key];
      _results.push(value[prop]);
    }
    return _results;
  };

  Object.values = function(object) {
    var value, _results;
    _results = [];
    for (key in object) {
      if (!__hasProp.call(object, key)) continue;
      value = object[key];
      _results.push(value);
    }
    return _results;
  };

  Object.canRespondTo = function() {
    var arg, args, object, ret, _i, _len;
    object = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    ret = true;
    for (_i = 0, _len = args.length; _i < _len; _i++) {
      arg = args[_i];
      if (typeof object[arg] !== 'function') {
        ret = false;
      }
    }
    return ret;
  };

  /*
  --------------- /home/gszikszai/git/crystal/source/types/number.coffee--------------
  */


  Object.defineProperties(Number.prototype, {
    seconds: {
      get: function() {
        return this.valueOf() * 1e+3;
      }
    },
    minutes: {
      get: function() {
        return this.valueOf() * 6e+4;
      }
    },
    hours: {
      get: function() {
        return this.valueOf() * 3.6e+6;
      }
    },
    days: {
      get: function() {
        return this.valueOf() * 8.64e+7;
      }
    },
    upto: {
      value: function(limit, func, bound) {
        var i, _results;
        if (bound == null) {
          bound = this;
        }
        i = parseInt(this);
        _results = [];
        while (i <= limit) {
          func.call(bound, i);
          _results.push(i++);
        }
        return _results;
      }
    },
    downto: {
      value: function(limit, func, bound) {
        var i, _results;
        if (bound == null) {
          bound = this;
        }
        i = parseInt(this);
        _results = [];
        while (i >= limit) {
          func.call(bound, i);
          _results.push(i--);
        }
        return _results;
      }
    },
    times: {
      value: function(func, bound) {
        var i, _i, _ref, _results;
        if (bound == null) {
          bound = this;
        }
        _results = [];
        for (i = _i = 1, _ref = parseInt(this); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
          _results.push(func.call(bound, i));
        }
        return _results;
      }
    },
    clamp: {
      value: function(min, max) {
        var val;
        min = parseFloat(min);
        max = parseFloat(max);
        val = this.valueOf();
        if (val > max) {
          return max;
        } else if (val < min) {
          return min;
        } else {
          return val;
        }
      }
    },
    clampRange: {
      value: function(min, max) {
        var val;
        min = parseFloat(min);
        max = parseFloat(max);
        val = this.valueOf();
        if (val > max) {
          return val % max;
        } else if (val < min) {
          return max - Math.abs(val % max);
        } else {
          return val;
        }
      }
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/types/date.coffee--------------
  */


  Date.Locale = {
    ago: {
      seconds: " seconds ago",
      minutes: " minutes ago",
      hours: " hours ago",
      days: " days ago",
      now: "just now"
    },
    format: "%Y-%M-%D"
  };

  Object.defineProperties(Date.prototype, {
    ago: {
      get: function() {
        var diff;
        diff = +new Date() - this;
        if (diff < 1..seconds) {
          return Date.Locale.ago.now;
        } else if (diff < 1..minutes) {
          return Math.round(diff / 1000) + Date.Locale.ago.seconds;
        } else if (diff < 1..hours) {
          return Math.round(diff / 1..minutes) + Date.Locale.ago.minutes;
        } else if (diff < 1..days) {
          return Math.round(diff / 1..hours) + Date.Locale.ago.hours;
        } else if (diff < 30..days) {
          return Math.round(diff / 1..days) + Date.Locale.ago.days;
        } else {
          return this.format(Date.Locale.format);
        }
      }
    },
    format: {
      value: function(str) {
        var _this = this;
        if (str == null) {
          str = Date.Locale.format;
        }
        return str.replace(/%([a-zA-z])/g, function($0, $1) {
          switch ($1) {
            case 'D':
              return _this.getDate().toString().replace(/^\d$/, "0$&");
            case 'd':
              return _this.getDate();
            case 'Y':
              return _this.getFullYear();
            case 'h':
              return _this.getHours();
            case 'H':
              return _this.getHours().toString().replace(/^\d$/, "0$&");
            case 'M':
              return (_this.getMonth() + 1).toString().replace(/^\d$/, "0$&");
            case 'm':
              return _this.getMonth() + 1;
            case "T":
              return _this.getMinutes().toString().replace(/^\d$/, "0$&");
            case "t":
              return _this.getMinutes();
            default:
              return "";
          }
        });
      }
    }
  });

  ['day:Date', 'year:FullYear', 'hours:Hours', 'minutes:Minutes', 'seconds:Seconds'].forEach(function(item) {
    var meth, prop, _ref;
    _ref = item.split(/:/), prop = _ref[0], meth = _ref[1];
    return Object.defineProperty(Date.prototype, prop, {
      get: function() {
        return this["get" + meth]();
      },
      set: function(value) {
        return this["set" + meth](parseInt(value));
      }
    });
  });

  Object.defineProperty(Date.prototype, 'month', {
    get: function() {
      return this.getMonth() + 1;
    },
    set: function(value) {
      return this.setMonth(value - 1);
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/logger/logger.coffee--------------
  */


  window.Logger = Logging.Logger = (function() {

    Logger.DEBUG = 4;

    Logger.INFO = 3;

    Logger.WARN = 2;

    Logger.ERROR = 1;

    Logger.FATAL = 0;

    Logger.LOG = 4;

    function Logger(level) {
      if (level == null) {
        level = 4;
      }
      if (isNaN(parseInt(level))) {
        throw "Level must be Number";
      }
      this._level = parseInt(level).clamp(0, 4);
      this._timestamp = true;
    }

    Logger.prototype._format = function() {
      var args, line;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      line = "";
      if (this.timestamp) {
        line += "[" + new Date().format("%Y-%M-%D %H:%T") + "] ";
      }
      return line += args.map(function(arg) {
        return args.toString();
      }).join(",");
    };

    return Logger;

  })();

  Object.defineProperties(Logger.prototype, {
    timestamp: {
      set: function(value) {
        return this._timestamp = !!value;
      },
      get: function() {
        return this._timestamp;
      }
    },
    level: {
      set: function(value) {
        return this._level = parseInt(value).clamp(0, 4);
      },
      get: function() {
        return this._level;
      }
    }
  });

  ['debug', 'log', 'error', 'fatal', 'info', 'warn'].forEach(function(type) {
    Logger.prototype["_" + type] = function() {};
    return Logger.prototype[type] = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (this.level >= Logging.Logger[type.toUpperCase()]) {
        return this["_" + type](this._format(args));
      }
    };
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/dom/element.coffee--------------
  */


  Attributes = {
    title: {
      prefix: "!",
      unique: true
    },
    name: {
      prefix: "&",
      unique: true
    },
    type: {
      prefix: "%",
      unique: true
    },
    id: {
      prefix: "#",
      unique: true
    },
    "class": {
      prefix: "\\.",
      unique: false
    },
    role: {
      prefix: "~",
      unique: true
    }
  };

  prefixes = Object.pluck(Attributes, 'prefix').concat("$").join("|");

  Object.each(Attributes, function(key, value) {
    return value.regexp = new RegExp(value.prefix + ("(.*?)(?=" + prefixes + ")"), "g");
  });

  _wrap = NodeList._wrap = function(fn) {
    return function() {
      var args, el, _i, _len, _results;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = this.length; _i < _len; _i++) {
        el = this[_i];
        _results.push(fn.apply(el, args));
      }
      return _results;
    };
  };

  _find = function(property, selector, el) {
    while (el = el[property]) {
      if (el instanceof Element) {
        if (el.webkitMatchesSelector(selector)) {
          return el;
        }
      }
    }
  };

  _parseName = function(name, atts) {
    var cssattributes, ret;
    if (atts == null) {
      atts = {};
    }
    cssattributes = {};
    name = name.replace(/\[(.*?)=(.*?)\]/g, function(m, name, value) {
      cssattributes[name] = value;
      return "";
    });
    name = name.replace(/\[(.*)?\]/g, function(m, name) {
      cssattributes[name] = true;
      return "";
    });
    ret = {
      tag: name.match(new RegExp("^.*?(?=" + prefixes + ")"))[0] || 'div',
      attributes: cssattributes
    };
    Object.each(Attributes, function(key, value) {
      var m, map;
      if ((m = name.match(value.regexp)) !== null) {
        name = name.replace(value.regexp, "");
        if (value.unique) {
          if (atts[key]) {
            if (atts[key] !== null && atts[key] !== void 0) {
              return ret.attributes[key] = atts[key];
            }
          } else {
            return ret.attributes[key] = m.pop().slice(1);
          }
        } else {
          map = m.map(function(item) {
            return item.slice(1);
          });
          if (atts[key]) {
            if (typeof atts[key] === 'string') {
              map = map.concat(atts[key].split(" "));
            } else {
              map = map.concat(atts[key]);
            }
          }
          return ret.attributes[key] = map.compact().join(" ");
        }
      } else {
        if (atts[key] !== null && atts[key] !== void 0) {
          return ret.attributes[key] = atts[key];
        }
      }
    });
    return ret;
  };

  methods_node = {
    append: function() {
      var el, elements, _i, _len, _results;
      elements = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = elements.length; _i < _len; _i++) {
        el = elements[_i];
        if (el instanceof Node) {
          _results.push(this.appendChild(el));
        }
      }
      return _results;
    },
    first: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return this.querySelector(selector);
    },
    last: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return this.querySelectorAll(selector).last;
    },
    all: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return this.querySelectorAll(selector);
    },
    empty: function() {
      return this.querySelectorAll("*").dispose();
    },
    moveUp: function() {
      var prev;
      if (this.parent && (prev = this.prev())) {
        return this.parent.insertBefore(this, prev);
      }
    },
    moveDown: function() {
      var next;
      if (this.parent && (next = this.next())) {
        return this.parent.insertBefore(next, this);
      }
    },
    indexOf: function(el) {
      return Array.prototype.slice.call(this.childNodes).indexOf(el);
    }
  };

  methods_element = {
    dispose: function() {
      var _ref;
      return (_ref = this.parent) != null ? _ref.removeChild(this) : void 0;
    },
    ancestor: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return _find('parentElement', selector, this);
    },
    next: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return _find('nextSibling', selector, this);
    },
    prev: function(selector) {
      if (selector == null) {
        selector = "*";
      }
      return _find('previousSibling', selector, this);
    },
    css: function() {
      var args, property, value;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      property = args[0];
      if (args.length === 1) {
        if (this.currentStyle) {
          value = this.currentStyle[property];
        } else {
          value = window.getComputedStyle(this)[property];
        }
        return value;
      }
      if (args.length === 2) {
        value = args[1];
        return this.style[property] = value;
      }
    }
  };

  for (key in methods_node) {
    method = methods_node[key];
    Object.defineProperty(Node.prototype, key, {
      value: method
    });
  }

  for (key in methods_element) {
    method = methods_element[key];
    Object.defineProperty(NodeList.prototype, key, {
      value: _wrap(method)
    });
    Object.defineProperty(HTMLElement.prototype, key, {
      value: method
    });
  }

  Object.defineProperty(HTMLSelectElement.prototype, 'selectedOption', {
    get: function() {
      if (this.children) {
        return this.children[this.selectedIndex];
      }
    },
    set: function(el) {
      if (this.childNodes.include(el)) {
        return this.selectedIndex = Array.prototype.slice.call(this.children).indexOf(el);
      }
    }
  });

  Object.defineProperty(HTMLInputElement.prototype, 'caretToEnd', {
    value: function() {
      var length;
      length = this.value.length;
      return this.setSelectionRange(length, length);
    }
  });

  properties = {
    id: {
      get: function() {
        return this.getAttribute('id');
      },
      set: function(value) {
        return this.setAttribute('id', value);
      }
    },
    tag: {
      get: function() {
        return this.tagName.toLowerCase();
      }
    },
    parent: {
      get: function() {
        return this.parentElement;
      },
      set: function(el) {
        if (!(el instanceof HTMLElement)) {
          return;
        }
        return el.append(this);
      }
    },
    text: {
      get: function() {
        return this.textContent;
      },
      set: function(value) {
        return this.textContent = value;
      }
    },
    html: {
      get: function() {
        return this.innerHTML;
      },
      set: function(value) {
        return this.innerHTML = value;
      }
    },
    "class": {
      get: function() {
        return this.getAttribute('class');
      },
      set: function(value) {
        return this.setAttribute('class', value);
      }
    }
  };

  Object.defineProperties(HTMLElement.prototype, properties);

  Object.defineProperty(Node.prototype, 'delegateEventListener', {
    value: function(event, listener, useCapture) {
      var baseEvent, selector, _ref;
      _ref = event.split(':'), baseEvent = _ref[0], selector = _ref[1];
      if (selector == null) {
        selector = "*";
      }
      return this.addEventListener(baseEvent, function(e) {
        var target;
        target = e.relatedTarget || e.target;
        if (target.webkitMatchesSelector(selector)) {
          return listener(e);
        }
      }, true);
    }
  });

  ['addEventListener', 'removeEventListener', 'delegateEventListener'].forEach(function(prop) {
    Object.defineProperty(Node.prototype, prop.replace("Listener", ''), {
      value: Node.prototype[prop]
    });
    return Object.defineProperty(window, prop.replace("Listener", ''), {
      value: window[prop]
    });
  });

  Element.create = function(node, atts) {
    var attributes, desc, tag, value, _ref;
    if (atts == null) {
      atts = {};
    }
    if (node instanceof Node) {
      return node;
    }
    switch (typeof node) {
      case 'string':
        _ref = _parseName(node, atts), tag = _ref.tag, attributes = _ref.attributes;
        node = document.createElement(tag.replace(/[^A-Za-z_\-0-9]/, ''));
        for (key in attributes) {
          value = attributes[key];
          if ((desc = properties[key])) {
            node[key] = value;
            continue;
          }
          node.setAttribute(key, value);
        }
        break;
      default:
        node = document.createElement('div');
    }
    return node;
  };

  Node;


  /*
  --------------- /home/gszikszai/git/crystal/source/logger/flash-logger.coffee--------------
  */


  window.FlashLogger = Logging.FlashLogger = (function(_super) {

    __extends(FlashLogger, _super);

    function FlashLogger(el, level) {
      if (!(el instanceof HTMLElement)) {
        throw "Base Element must be HTMLElement";
      }
      FlashLogger.__super__.constructor.call(this, level);
      this.visible = false;
      this.el = el;
    }

    FlashLogger.prototype.hide = function() {
      var _this = this;
      clearTimeout(this.id);
      return this.id = setTimeout(function() {
        _this.visible = false;
        _this.el.classList.toggle('hidden');
        return _this.el.classList.toggle('visible');
      }, 2000);
    };

    return FlashLogger;

  })(Logging.Logger);

  ['debug', 'error', 'fatal', 'info', 'warn', 'log'].forEach(function(type) {
    return FlashLogger.prototype["_" + type] = function(text) {
      if (this.visible) {
        this.el.html += "</br>" + text;
        return this.hide();
      } else {
        this.el.text = text;
        this.el.classList.toggle('hidden');
        this.el.classList.toggle('visible');
        this.visible = true;
        return this.hide();
      }
    };
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/logger/console-logger.coffee--------------
  */


  window.ConsoleLogger = Logging.ConsoleLogger = (function(_super) {

    __extends(ConsoleLogger, _super);

    function ConsoleLogger() {
      ConsoleLogger.__super__.constructor.apply(this, arguments);
    }

    return ConsoleLogger;

  })(Logging.Logger);

  ['debug', 'error', 'fatal', 'info', 'warn', 'log'].forEach(function(type) {
    return ConsoleLogger.prototype["_" + type] = function(text) {
      if (type === 'debug') {
        type = 'log';
      }
      if (type === 'fatal') {
        type = 'error';
      }
      return console[type](text);
    };
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/logger/html-logger.coffee--------------
  */


  css = {
    error: {
      color: 'orangered'
    },
    info: {
      color: 'blue'
    },
    warn: {
      color: 'orange'
    },
    fatal: {
      color: 'red',
      'font-weight': 'bold'
    },
    debug: {
      color: 'black'
    },
    log: {
      color: 'black'
    }
  };

  window.HTMLLogger = Logging.HTMLLogger = (function(_super) {

    __extends(HTMLLogger, _super);

    function HTMLLogger(el, level) {
      if (!(el instanceof HTMLElement)) {
        throw "Base Element must be HTMLElement";
      }
      HTMLLogger.__super__.constructor.call(this, level);
      this.el = el;
    }

    return HTMLLogger;

  })(Logging.Logger);

  ['debug', 'error', 'fatal', 'info', 'warn', 'log'].forEach(function(type) {
    return HTMLLogger.prototype["_" + type] = function(text) {
      var el, prop, value, _ref;
      el = Element.create('div.' + type);
      _ref = css[type];
      for (prop in _ref) {
        value = _ref[prop];
        el.css(prop, value);
      }
      el.text = text;
      this.el.append(el);
      return el;
    };
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/store/store.coffee--------------
  */


  window.Store = Store.Store = (function() {

    function Store(options) {
      var a, ad, adapter, indexedDB, localStore, requestFileSystem, websql, xhr,
        _this = this;
      if (options == null) {
        options = {};
      }
      this.prefix = options.prefix || "";
      ad = parseInt(options.adapter) || 0;
      if (options.serialize instanceof Function) {
        this.$serialize = options.serialize;
      }
      if (options.deserialize instanceof Function) {
        this.$deserialize = options.deserialize;
      }
      a = window;
      indexedDB = 'indexedDB' in a || 'webkitIndexedDB' in a || 'mozIndexedDB' in a;
      requestFileSystem = 'requestFileSystem' in a || 'webkitRequestFileSystem' in a;
      websql = 'openDatabase' in a;
      localStore = 'localStorage' in a;
      xhr = 'XMLHttpRequest' in a;
      adapter = (function() {
        switch (ad) {
          case 0:
            if (indexedDB) {
              return Store.IndexedDB;
            } else if (websql) {
              return Store.WebSQL;
            } else if (requestFileSystem) {
              return Store.FileSystem;
            } else if (xhr) {
              return Store.Request;
            } else if (localStorage) {
              return Store.LocalStorage;
            } else {
              return Store.Memory;
            }
            break;
          case 1:
            if (!indexedDB) {
              throw "IndexedDB not supported!";
            }
            return Store.IndexedDB;
          case 2:
            if (!websql) {
              throw "WebSQL not supported!";
            }
            return Store.WebSQL;
          case 3:
            if (!requestFileSystem) {
              throw "FileSystem not supported!";
            }
            return Store.FileSystem;
          case 4:
            if (!localStorage) {
              throw "LocalStorage not supported!";
            }
            return Store.LocalStorage;
          case 5:
            if (!xhr) {
              throw "XHR not supported!";
            }
            return Store.Request;
          case 6:
            return Store.Memory;
          default:
            throw "Adapter not found!";
        }
      })();
      ['get', 'set', 'remove', 'list'].forEach(function(item) {
        return _this[item] = function() {
          var args;
          args = Array.prototype.slice.call(arguments);
          if (this.running) {
            this.chain(item, args);
          } else {
            this.call(item, args);
          }
          return this;
        };
      });
      this.$chain = [];
      this.adapter = new adapter();
      this.adapter.init.call(this, function(store) {
        _this.ready = true;
        if (typeof options.callback === "function") {
          options.callback(_this);
        }
        return _this.callChain();
      });
    }

    Store.prototype.error = function() {
      return console.error(arguments);
    };

    Store.prototype.serialize = function(obj) {
      if (this.$serialize) {
        return this.$serialize(obj);
      }
      return JSON.stringify(obj);
    };

    Store.prototype.deserialize = function(json) {
      if (this.$deserialize) {
        return this.$deserialize(obj);
      }
      return JSON.parse(json);
    };

    Store.prototype.chain = function(type, args) {
      return this.$chain.push([type, args]);
    };

    Store.prototype.callChain = function() {
      var first;
      if (this.$chain.length > 0) {
        first = this.$chain.shift();
        return this.call(first[0], first[1]);
      }
    };

    Store.prototype.call = function(type, args) {
      var callback,
        _this = this;
      if (!this.ready) {
        return this.chain(type, args);
      } else {
        this.running = true;
        if ((type === 'set' && args.length === 3) || (type === 'list' && args.length === 1) || ((type === 'get' || type === 'remove') && args.length === 2)) {
          callback = args.pop();
        }
        return this.adapter[type].apply(this, args.concat(function(data) {
          if (typeof callback === 'function') {
            callback(data);
          }
          _this.running = false;
          return _this.callChain();
        }));
      }
    };

    Store.ADAPTER_BEST = 0;

    Store.INDEXED_DB = 1;

    Store.WEB_SQL = 2;

    Store.FILE_SYSTEM = 3;

    Store.LOCAL_STORAGE = 4;

    Store.XHR = 5;

    Store.MEMORY = 6;

    return Store;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/localstorage.coffee--------------
  */


  window.Store.LocalStorage = Store.LocalStorage = (function() {

    function LocalStorage() {}

    LocalStorage.prototype.init = function(callback) {
      if (this.prefix !== "") {
        this.prefix += "::";
      }
      return callback(this);
    };

    LocalStorage.prototype.get = function(key, callback) {
      var ret;
      try {
        ret = this.deserialize(localStorage.getItem(this.prefix + key.toString()));
      } catch (error) {
        this.error(error);
      }
      return callback(ret || false);
    };

    LocalStorage.prototype.set = function(key, value, callback) {
      var ret;
      try {
        localStorage.setItem(this.prefix + key.toString(), this.serialize(value));
        ret = true;
      } catch (error) {
        this.error(error);
      }
      return callback(ret || false);
    };

    LocalStorage.prototype.list = function(callback) {
      var i, ret, _i, _ref;
      ret = [];
      for (i = _i = 0, _ref = localStorage.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        try {
          key = localStorage.key(i);
          if (this.prefix !== "") {
            if (new RegExp("^" + this.prefix).test(key)) {
              ret.push(key.replace(new RegExp("^" + this.prefix), ""));
            }
          } else {
            ret.push(key);
          }
        } catch (error) {
          this.error(error);
        }
      }
      return callback(ret);
    };

    LocalStorage.prototype.remove = function(key, callback) {
      var ret;
      if (localStorage.getItem(this.prefix + key) === null) {
        callback(false);
        return;
      }
      try {
        localStorage.removeItem(this.prefix + key.toString());
        ret = true;
      } catch (error) {
        this.error(error);
      }
      return callback(ret || false);
    };

    return LocalStorage;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/memory.coffee--------------
  */


  window.Store.Memory = Store.Memory = (function() {

    function Memory() {}

    Memory.prototype.init = function(callback) {
      this.store = {};
      return typeof callback === "function" ? callback(this) : void 0;
    };

    Memory.prototype.get = function(key, callback) {
      var a, ret;
      if ((a = this.store[key.toString()])) {
        ret = this.deserialize(a);
      } else {
        ret = false;
      }
      return typeof callback === "function" ? callback(ret) : void 0;
    };

    Memory.prototype.set = function(key, value, callback) {
      var ret;
      try {
        this.store[key.toString()] = this.serialize(value);
        ret = true;
      } catch (error) {
        this.error(error);
      }
      return typeof callback === "function" ? callback(ret || false) : void 0;
    };

    Memory.prototype.list = function(callback) {
      var ret;
      ret = [];
      try {
        ret = (function() {
          var _ref, _results;
          _ref = this.store;
          _results = [];
          for (key in _ref) {
            if (!__hasProp.call(_ref, key)) continue;
            _results.push(key);
          }
          return _results;
        }).call(this);
      } catch (error) {
        this.error(error);
      }
      return typeof callback === "function" ? callback(ret) : void 0;
    };

    Memory.prototype.remove = function(key, callback) {
      var ret;
      if (this.store[key.toString()] === void 0) {
        callback(false);
        return;
      }
      try {
        delete this.store[key.toString()];
        ret = true;
      } catch (error) {
        this.error(error);
      }
      return typeof callback === "function" ? callback(ret || false) : void 0;
    };

    return Memory;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/file-system.coffee--------------
  */


  window.Store.FileSystem = Store.FileSystem = (function() {

    function FileSystem() {}

    FileSystem.prototype.init = function(callback) {
      var rfs,
        _this = this;
      rfs = window.RequestFileSystem || window.webkitRequestFileSystem;
      return rfs(window.PRESISTENT, 50 * 1024 * 1024, function(store) {
        _this.storage = store;
        return callback(_this);
      }, this.error);
    };

    FileSystem.prototype.list = function(callback) {
      var dirReader, entries, readEntries,
        _this = this;
      dirReader = this.storage.root.createReader();
      entries = [];
      readEntries = function() {
        return dirReader.readEntries(function(results) {
          if (!results.length) {
            entries.sort();
            return callback(entries.map(function(item) {
              return item.name;
            }));
          } else {
            entries = entries.concat(Array.prototype.slice.call(results));
            return readEntries();
          }
        }, _this.error);
      };
      return readEntries();
    };

    FileSystem.prototype.remove = function(file, callback) {
      var _this = this;
      return this.storage.root.getFile(file, null, function(fe) {
        return fe.remove(function() {
          return callback(true);
        }, function() {
          return callback(false);
        });
      }, function() {
        return callback(false);
      });
    };

    FileSystem.prototype.get = function(file, callback) {
      var _this = this;
      return this.storage.root.getFile(file, null, function(fe) {
        return fe.file(function(f) {
          var reader;
          reader = new FileReader();
          reader.onloadend = function(e) {
            return callback(_this.deserialize(e.target.result));
          };
          return reader.readAsText(f);
        }, function() {
          return callback(false);
        });
      }, function() {
        return callback(false);
      });
    };

    FileSystem.prototype.set = function(file, data, callback) {
      var _this = this;
      if (callback == null) {
        callback = function() {};
      }
      return this.storage.root.getFile(file, {
        create: true
      }, function(fe) {
        return fe.createWriter(function(fileWriter) {
          var bb;
          fileWriter.onwriteend = function(e) {
            return callback(true);
          };
          fileWriter.onerror = function(e) {
            return callback(false);
          };
          bb = new (window.WebKitBlobBuilder || BlobBuilder());
          bb.append(_this.serialize(data));
          return fileWriter.write(bb.getBlob('text/plain'));
        }, function() {
          return callback(false);
        });
      }, function() {
        return callback(false);
      });
    };

    return FileSystem;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/websql.coffee--------------
  */


  window.Store.WebSQL = Store.WebSQL = (function() {

    function WebSQL() {}

    WebSQL.prototype.init = function(callback) {
      var _this = this;
      this.exec = function(statement, callback, args) {
        var _this = this;
        if (callback == null) {
          callback = (function() {});
        }
        return this.db.transaction(function(tr) {
          return tr.executeSql(statement, args, callback, function(tr, err) {
            return callback(false);
          }, function() {
            return callback(false);
          });
        });
      };
      this.db = openDatabase(this.prefix, '1.0', 'Store', 5 * 1024 * 1024);
      return this.exec("CREATE TABLE IF NOT EXISTS store ( 'key' VARCHAR PRIMARY KEY NOT NULL, 'value' TEXT)", function() {
        return callback(_this);
      });
    };

    WebSQL.prototype.get = function(key, callback) {
      var _this = this;
      return this.exec("SELECT * FROM store WHERE key = '" + key + "'", function(tr, result) {
        var ret;
        if (result.rows.length > 0) {
          ret = _this.deserialize(result.rows.item(0).value);
        } else {
          ret = false;
        }
        return callback.call(_this, ret);
      });
    };

    WebSQL.prototype.set = function(key, value, callback) {
      var _this = this;
      return this.exec("SELECT * FROM store WHERE key = '" + key + "'", function(tr, result) {
        if (!(result.rows.length > 0)) {
          return _this.exec("INSERT INTO store (key, value) VALUES ('" + key + "','" + (_this.serialize(value)) + "')", function(tr, result) {
            if (result.rowsAffected === 1) {
              return callback(true);
            } else {
              return callback(false);
            }
          });
        } else {
          return _this.exec("UPDATE store SET value = '" + (_this.serialize(value)) + "' WHERE key = '" + key + "'", function(tr, result) {
            if (result.rowsAffected === 1) {
              return callback(true);
            } else {
              return callback(false);
            }
          });
        }
      });
    };

    WebSQL.prototype.list = function(callback) {
      var _this = this;
      return this.exec("SELECT key FROM store", function(tr, results) {
        var keys, _i, _ref, _results;
        keys = [];
        if (results.rows.length > 0) {
          (function() {
            _results = [];
            for (var _i = 0, _ref = results.rows.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
            return _results;
          }).apply(this).forEach(function(i) {
            return keys.push(results.rows.item(i).key);
          });
        }
        return callback(keys);
      });
    };

    WebSQL.prototype.remove = function(key, callback) {
      var _this = this;
      return this.exec("DELETE FROM store WHERE key = '" + key + "'", function(tr, result) {
        if (result.rowsAffected === 1) {
          return callback(true);
        } else {
          return callback(false);
        }
      });
    };

    return WebSQL;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/indexed-db.coffee--------------
  */


  window.Store.IndexedDB = Store.IndexedDB = (function() {

    function IndexedDB() {}

    IndexedDB.prototype.init = function(callback) {
      var a, request,
        _this = this;
      this.version = "2";
      this.database = 'store';
      a = window;
      a.indexedDB = a.indexedDB || a.webkitIndexedDB || a.mozIndexedDB;
      request = window.indexedDB.open(this.prefix, this.version);
      request.onupgradeneeded = function(e) {
        var store;
        _this.db = e.target.result;
        if (!_this.db.objectStoreNames.contains("note")) {
          return store = _this.db.createObjectStore(_this.database, {
            keyPath: "key"
          });
        }
      };
      request.onsuccess = function(e) {
        var setVrequest;
        _this.db = e.target.result;
        if (__indexOf.call(_this.db, 'setVersion') >= 0) {
          if (_this.version !== _this.db.version) {
            setVrequest = _this.db.setVersion(_this.version);
            setVrequest.onfailure = _this.error;
            return setVrequest.onsuccess = function(e) {
              var store, trans;
              store = _this.db.createObjectStore(_this.database, {
                keyPath: "key"
              });
              trans = setVrequest.result;
              return trans.oncomplete = function() {
                return callback(this);
              };
            };
          } else {
            return callback(_this);
          }
        } else {
          return callback(_this);
        }
      };
      return request.onfailure = this.error;
    };

    IndexedDB.prototype.get = function(key, callback) {
      var request, store, trans,
        _this = this;
      trans = this.db.transaction([this.database], 'readwrite');
      store = trans.objectStore(this.database);
      request = store.get(key.toString());
      request.onerror = function() {
        return callback(false);
      };
      return request.onsuccess = function(e) {
        var result;
        result = e.target.result;
        if (result) {
          return callback(_this.deserialize(result.value));
        } else {
          return callback(false);
        }
      };
    };

    IndexedDB.prototype.set = function(key, value, callback) {
      var request, store, trans;
      trans = this.db.transaction([this.database], 'readwrite');
      store = trans.objectStore(this.database);
      request = store.put({
        key: key.toString(),
        value: this.serialize(value)
      });
      request.onsuccess = function() {
        return callback(true);
      };
      return request.onerror = this.error;
    };

    IndexedDB.prototype.list = function(callback) {
      var cursorRequest, ret, store, trans,
        _this = this;
      trans = this.db.transaction([this.database], 'readwrite');
      store = trans.objectStore(this.database);
      cursorRequest = store.openCursor();
      cursorRequest.onerror = this.error;
      ret = [];
      return cursorRequest.onsuccess = function(e) {
        var result;
        result = e.target.result;
        if (result) {
          ret.push(result.value.key);
          return result["continue"]();
        } else {
          return callback(ret);
        }
      };
    };

    IndexedDB.prototype.remove = function(key, callback) {
      var r, store, trans,
        _this = this;
      trans = this.db.transaction([this.database], 'readwrite');
      store = trans.objectStore(this.database);
      r = store.get(key.toString());
      r.onerror = function() {
        return callback(false);
      };
      return r.onsuccess = function(e) {
        var result;
        result = e.target.result;
        if (result) {
          r = store["delete"](key.toString());
          r.onsuccess = function() {
            return callback(true);
          };
          return r.onerror = function() {
            return callback(false);
          };
        } else {
          return callback(false);
        }
      };
    };

    return IndexedDB;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/types/string.coffee--------------
  */


  Object.defineProperties(String.prototype, {
    wordWrap: {
      value: function(width, separator, cut) {
        var regex;
        if (width == null) {
          width = 15;
        }
        if (separator == null) {
          separator = "\n";
        }
        if (cut == null) {
          cut = false;
        }
        regex = ".{1," + width + "}(\\s|$)" + (cut ? "|.{" + width + "}|.+$" : "|\\S+?(\\s|$)");
        return this.match(RegExp(regex, "g")).join(separator);
      }
    },
    test: {
      value: function(regexp) {
        return !!this.match(regexp);
      }
    },
    escape: {
      value: function() {
        return this.replace(/[-[\]{}()*+?.\/'\\^$|#]/g, "\\$&");
      }
    },
    ellipsis: {
      value: function(length) {
        if (length == null) {
          length = 10;
        }
        if (this.length > length) {
          return this.slice(0, (length - 1) + 1 || 9e9) + "...";
        } else {
          return this.valueOf();
        }
      }
    },
    compact: {
      value: function() {
        var s;
        s = this.valueOf().trim();
        return s.replace(/\s+/g, ' ');
      }
    },
    camelCase: {
      value: function() {
        return this.replace(/[- _](\w)/g, function(matches) {
          return matches[1].toUpperCase();
        });
      }
    },
    hyphenate: {
      value: function() {
        return this.replace(/^[A-Z]/, function(match) {
          return match.toLowerCase();
        }).replace(/[A-Z]/g, function(match) {
          return "-" + match.toLowerCase();
        });
      }
    },
    capitalize: {
      value: function() {
        return this.replace(/^\w|\s\w/g, function(match) {
          return match.toUpperCase();
        });
      }
    },
    indent: {
      value: function(spaces) {
        var s;
        if (spaces == null) {
          spaces = 2;
        }
        s = '';
        spaces = spaces.times(function() {
          return s += " ";
        });
        return this.replace(/^/gm, s);
      }
    },
    outdent: {
      value: function(spaces) {
        if (spaces == null) {
          spaces = 2;
        }
        return this.replace(new RegExp("^\\s{" + spaces + "}", "gm"), "");
      }
    },
    entities: {
      value: function() {
        return this.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
      }
    },
    parseQueryString: {
      value: function() {
        var match, regexp, ret;
        ret = {};
        regexp = /([^&=]+)=([^&]*)/g;
        while (match = regexp.exec(this)) {
          ret[decodeURIComponent(match[1])] = decodeURIComponent(match[2]);
        }
        return ret;
      }
    }
  });

  String.random = function(length) {
    var chars, i, str, _i, _ref;
    if (length == null) {
      length = 10;
    }
    chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('');
    if (!length) {
      length = Math.floor(Math.random() * chars.length);
    }
    str = '';
    for (i = _i = 0, _ref = length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      str += chars.sample;
    }
    return str;
  };

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/request.coffee--------------
  */


  window.Response = Utils.Response = (function() {

    function Response(headers, body, status) {
      this.headers = headers;
      this.raw = body;
      this.status = status;
    }

    return Response;

  })();

  types = {
    script: ['text/javascript'],
    html: ['text/html'],
    JSON: ['text/json', 'application/json'],
    XML: ['text/xml']
  };

  Object.each(types, function(key, value) {
    return Object.defineProperty(Response.prototype, 'is' + key.capitalize(), {
      value: function() {
        var _this = this;
        return value.map(function(type) {
          return _this.headers['Content-Type'] === type;
        }).compact().length > 0;
      }
    });
  });

  Object.defineProperty(Response.prototype, 'body', {
    get: function() {
      var df, div, node, p, _i, _len, _ref;
      switch (this.headers['Content-Type']) {
        case "text/html":
          div = document.createElement('div');
          div.innerHTML = this.raw;
          df = document.createDocumentFragment();
          _ref = Array.prototype.slice.call(div.childNodes);
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            node = _ref[_i];
            df.appendChild(node);
          }
          return df;
        case "text/json":
        case "application/json":
          try {
            return JSON.parse(this.raw);
          } catch (e) {
            return this.raw;
          }
          break;
        case "text/xml":
          p = new DOMParser();
          return p.parseFromString(this.raw, "text/xml");
        default:
          return this.raw;
      }
    }
  });

  window.Request = Utils.Request = (function() {

    function Request(url, headers) {
      if (headers == null) {
        headers = {};
      }
      this.handleStateChange = __bind(this.handleStateChange, this);

      this.uri = url;
      this.headers = headers;
      this._request = new XMLHttpRequest();
      this._request.onreadystatechange = this.handleStateChange;
    }

    Request.prototype.request = function(method, data, callback) {
      var value, _ref;
      if (method == null) {
        method = 'GET';
      }
      if ((this._request.readyState === 4) || (this._request.readyState === 0)) {
        if (method.toUpperCase() === 'GET' && data !== void 0 && data !== null) {
          this._request.open(method, this.uri + "?" + data.toQueryString());
        } else {
          this._request.open(method, this.uri);
        }
        _ref = this.headers;
        for (key in _ref) {
          if (!__hasProp.call(_ref, key)) continue;
          value = _ref[key];
          this._request.setRequestHeader(key.toString(), value.toString());
        }
        this._callback = callback;
        return this._request.send(data != null ? data.toFormData() : void 0);
      }
    };

    Request.prototype.parseResponseHeaders = function() {
      var r;
      r = {};
      this._request.getAllResponseHeaders().split(/\n/).compact().forEach(function(header) {
        var value, _ref;
        _ref = header.split(/:\s/), key = _ref[0], value = _ref[1];
        return r[key.trim()] = value.trim();
      });
      return r;
    };

    Request.prototype.handleStateChange = function() {
      var body, headers, status;
      if (this._request.readyState === 4) {
        headers = this.parseResponseHeaders();
        body = this._request.response;
        status = this._request.status;
        this._callback(new Response(headers, body, status));
        return this._request.responseText;
      }
    };

    return Request;

  })();

  ['get', 'post', 'put', 'delete', 'patch'].forEach(function(type) {
    return Request.prototype[type] = function() {
      var callback, data;
      if (arguments.length === 2) {
        data = arguments[0];
        callback = arguments[1];
      } else {
        callback = arguments[0];
      }
      return this.request(type.toUpperCase(), data, callback);
    };
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/store/adapters/xhr.coffee--------------
  */


  window.Store.Request = Store.XHR = (function() {

    function XHR() {}

    XHR.prototype.init = function(callback) {
      this.request = new Request(this.prefix);
      return callback(this);
    };

    XHR.prototype.get = function(key, callback) {
      var _this = this;
      return this.request.get({
        key: key
      }, function(response) {
        return typeof callback === "function" ? callback(_this.deserialize(response.body)) : void 0;
      });
    };

    XHR.prototype.set = function(key, value, callback) {
      var _this = this;
      return this.request.post({
        key: key,
        value: this.serialize(value)
      }, function(response) {
        return typeof callback === "function" ? callback(response.body) : void 0;
      });
    };

    XHR.prototype.list = function(callback) {
      var _this = this;
      return this.request.get(function(response) {
        return typeof callback === "function" ? callback(response.body) : void 0;
      });
    };

    XHR.prototype.remove = function(key, callback) {
      var _this = this;
      return this.request["delete"]({
        key: key
      }, function(response) {
        return typeof callback === "function" ? callback(response.body) : void 0;
      });
    };

    return XHR;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/evented.coffee--------------
  */


  Crystal.Utils.Event = Utils.Event = (function() {

    function Event(target) {
      if (!target) {
        throw "No target";
      }
      if (!(target instanceof Object)) {
        throw "Invalid target!";
      }
      this.cancelled = false;
      this.target = target;
    }

    Event.prototype.stop = function() {
      return this.cancelled = true;
    };

    return Event;

  })();

  Utils.Mediator = (function() {

    function Mediator() {
      this.listeners = {};
    }

    Mediator.prototype.fireEvent = function(type, args) {
      var callback, event, _i, _len, _ref, _results;
      event = args.first;
      if (!(event instanceof Utils.Event)) {
        throw "Not Utils.Event!";
      }
      if (this.listeners[type]) {
        _ref = this.listeners[type];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          callback = _ref[_i];
          if (!event.cancelled) {
            _results.push(callback.apply(event.target, args));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    };

    Mediator.prototype.addListener = function(type, callback) {
      if (!(callback instanceof Function)) {
        throw "Only functions can be added as callback";
      }
      if (!this.listeners[type]) {
        this.listeners[type] = [];
      }
      return this.listeners[type].push(callback);
    };

    Mediator.prototype.removeListener = function(type, callback) {
      this.listeners[type].remove$(callback);
      if (this.listeners[type].length === 0) {
        return delete this.listeners[type];
      }
    };

    return Mediator;

  })();

  window.Mediator = new Utils.Mediator;

  Crystal.Utils.Evented = Utils.Evented = (function() {

    function Evented() {}

    Evented.prototype._ensureMediator = function() {
      if (!this._mediator) {
        return Object.defineProperty(this, "_mediator", {
          value: new Utils.Mediator
        });
      }
    };

    Evented.prototype.toString = function() {
      return "[Object " + this.__proto__.constructor.name + "]";
    };

    Evented.prototype.trigger = function() {
      var args, event, type;
      type = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      event = new Utils.Event(this);
      args.unshift(event);
      this._ensureMediator();
      return this._mediator.fireEvent(type, args);
    };

    Evented.prototype.on = function(type, callback) {
      this._ensureMediator();
      return this._mediator.addListener(type, callback);
    };

    Evented.prototype.off = function(type, callback) {
      this._ensureMediator();
      return this._mediator.removeListener(type, callback);
    };

    Evented.prototype.publish = function() {
      var args, event, type;
      type = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      event = new Utils.Event(this);
      args.unshift(event);
      return Mediator.fireEvent(type, args);
    };

    Evented.prototype.subscribe = function(type, callback) {
      return Mediator.addListener(type, callback);
    };

    Evented.prototype.unsubscribe = function(type, callback) {
      return Mediator.removeListener(type, callback);
    };

    return Evented;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/ui/list.coffee--------------
  */


  window.UI = {};

  UI.List = List = (function(_super) {

    __extends(List, _super);

    List.prototype.indexOf = function(el) {
      return this.base.indexOf(el);
    };

    List.prototype.itemOf = function(el) {
      return this.collection[this.base.indexOf(el)];
    };

    List.prototype.change = function(e, data) {
      var el, item, _i, _len, _ref;
      _ref = data.added;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (this.options.element instanceof HTMLElement) {
          el = this.options.element.cloneNode(true);
        } else if (this.options.element instanceof Function) {
          el = this.options.element(item[0]);
        } else {
          el = Element.create(this.options.element);
        }
        if (this.options.prepare instanceof Function) {
          this.options.prepare.call(this, el, item[0]);
        }
        this.add(el, item[1]);
      }
      this.remove(data.removed);
      return this.move(data.moved);
    };

    List.prototype.add = function(el, index) {
      return this.base.insertBefore(el, this.base.childNodes[index]);
    };

    List.prototype.remove = function(indexes) {
      var index;
      return ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = indexes.length; _i < _len; _i++) {
          index = indexes[_i];
          _results.push(this.base.childNodes[index]);
        }
        return _results;
      }).call(this)).forEach(function(el) {
        return el.dispose();
      });
    };

    List.prototype.move = function(moves) {
      var el, elements, i, what, _i, _len, _results,
        _this = this;
      elements = moves.map(function(move) {
        return _this.base.childNodes[move[0]];
      });
      _results = [];
      for (i = _i = 0, _len = elements.length; _i < _len; i = ++_i) {
        el = elements[i];
        what = this.base.childNodes[moves[i][1]];
        if (el && what) {
          _results.push(this.base.insertBefore(el, what));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    List.prototype.bind = function(collection) {
      var added, i, item;
      this.base.empty();
      if (this.collection) {
        this.collection.off('change', this.change);
      }
      this.collection = collection;
      this.collection.on('change', this.change);
      added = (function() {
        var _i, _len, _ref, _results;
        _ref = this.collection;
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          item = _ref[i];
          _results.push([item, i]);
        }
        return _results;
      }).call(this);
      return this.change(null, {
        added: added,
        removed: [],
        moved: []
      });
    };

    function List(options) {
      this.options = options;
      this.change = __bind(this.change, this);

      if (this.options.base instanceof HTMLElement) {
        this.base = this.options.base;
      } else {
        this.base = Element.create(this.options.base);
      }
      if (this.options.collection) {
        this.bind(this.options.collection);
      }
    }

    return List;

  })(Crystal.Utils.Evented);

  /*
  --------------- /home/gszikszai/git/crystal/source/crystal.coffee--------------
  */


  Types = {};

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/base64.coffee--------------
  */


  window.Base64 = new (Utils.Base64 = (function() {

    function Base64() {}

    Base64.prototype._keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    Base64.prototype.encode = function(input) {
      var chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, output;
      output = "";
      i = 0;
      input = this.UTF8Encode(input);
      while (i < input.length) {
        chr1 = input.charCodeAt(i++);
        chr2 = input.charCodeAt(i++);
        chr3 = input.charCodeAt(i++);
        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;
        if (isNaN(chr2)) {
          enc3 = enc4 = 64;
        } else {
          if (isNaN(chr3)) {
            enc4 = 64;
          }
        }
        output = output + this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);
      }
      return output;
    };

    Base64.prototype.decode = function(input) {
      var chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, output;
      output = "";
      i = 0;
      input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
      while (i < input.length) {
        enc1 = this._keyStr.indexOf(input.charAt(i++));
        enc2 = this._keyStr.indexOf(input.charAt(i++));
        enc3 = this._keyStr.indexOf(input.charAt(i++));
        enc4 = this._keyStr.indexOf(input.charAt(i++));
        chr1 = (enc1 << 2) | (enc2 >> 4);
        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
        chr3 = ((enc3 & 3) << 6) | enc4;
        output = output + String.fromCharCode(chr1);
        if (enc3 !== 64) {
          output = output + String.fromCharCode(chr2);
        }
        if (enc4 !== 64) {
          output = output + String.fromCharCode(chr3);
        }
      }
      output = this.UTF8Decode(output);
      return output;
    };

    Base64.prototype.UTF8Encode = function(string) {
      var c, n, utftext;
      string = string.replace(/\r\n/g, "\n");
      utftext = "";
      n = 0;
      while (n < string.length) {
        c = string.charCodeAt(n);
        if (c < 128) {
          utftext += String.fromCharCode(c);
        } else if ((c > 127) && (c < 2048)) {
          utftext += String.fromCharCode((c >> 6) | 192);
          utftext += String.fromCharCode((c & 63) | 128);
        } else {
          utftext += String.fromCharCode((c >> 12) | 224);
          utftext += String.fromCharCode(((c >> 6) & 63) | 128);
          utftext += String.fromCharCode((c & 63) | 128);
        }
        n++;
      }
      return utftext;
    };

    Base64.prototype.UTF8Decode = function(utftext) {
      var c, c1, c2, c3, i, string;
      string = "";
      i = 0;
      c = c1 = c2 = 0;
      while (i < utftext.length) {
        c = utftext.charCodeAt(i);
        if (c < 128) {
          string += String.fromCharCode(c);
          i++;
        } else if ((c > 191) && (c < 224)) {
          c2 = utftext.charCodeAt(i + 1);
          string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
          i += 2;
        } else {
          c2 = utftext.charCodeAt(i + 1);
          c3 = utftext.charCodeAt(i + 2);
          string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
          i += 3;
        }
      }
      return string;
    };

    return Base64;

  })());

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/history.coffee--------------
  */


  window.History = Utils.History = (function() {

    function History() {
      var _this = this;
      this._type = 'pushState' in history ? 'popstate' : 'hashchange';
      window.addEventListener(this._type, function(event) {
        var url;
        url = (function() {
          switch (this._type) {
            case 'popstate':
              return window.location.pathname;
            case 'hashchange':
              return window.location.hash;
          }
        }).call(_this);
        if (_this[url.trim()] instanceof Function) {
          return _this[url.trim()]();
        }
      });
      this.stateid = 0;
    }

    History.prototype.push = function(url) {
      switch (this._type) {
        case 'popstate':
          return history.pushState({}, this.stateid++, url);
        case 'hashchange':
          return window.location.hash = url;
      }
    };

    return History;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/json.coffee--------------
  */


  olds = JSON.stringify;

  JSON.stringify = function(obj) {
    if (obj instanceof Array) {
      return olds(Array.prototype.slice.call(obj));
    } else {
      return olds(obj);
    }
  };

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/path.coffee--------------
  */


  window.Path = Utils.Path = (function() {

    function Path(context) {
      this.context = context != null ? context : {};
    }

    Path.prototype.create = function(path, value) {
      var last, prop, segment, _i, _len;
      path = path.toString();
      last = this.context;
      prop = (path = path.split(/\./)).pop();
      for (_i = 0, _len = path.length; _i < _len; _i++) {
        segment = path[_i];
        if (!last.hasOwnProperty(segment)) {
          last[segment] = {};
        }
        last = last[segment];
      }
      return last[prop] = value;
    };

    Path.prototype.exists = function(path) {
      return this.lookup(path) !== void 0;
    };

    Path.prototype.lookup = function(path) {
      var end, last, segment, _i, _len;
      end = (path = path.split(/\./)).pop();
      if (path.length === 0 && !this.context.hasOwnProperty(end)) {
        return void 0;
      }
      last = this.context;
      for (_i = 0, _len = path.length; _i < _len; _i++) {
        segment = path[_i];
        if (last.hasOwnProperty(segment)) {
          last = last[segment];
        } else {
          return void 0;
        }
      }
      if (last.hasOwnProperty(end)) {
        return last[end];
      }
      return void 0;
    };

    return Path;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/i18n.coffee--------------
  */


  i18n = (function() {

    function i18n() {}

    i18n.locales = {};

    i18n.t = function(path) {
      var arg, locale, params, str, _path;
      if (arguments.length === 2) {
        if ((arg = arguments[1]) instanceof Object) {
          params = arg;
        } else {
          locale = arg;
        }
      }
      if (arguments.length === 3) {
        locale = arguments[2];
        params = arguments[1];
      }
      if (locale == null) {
        locale = document.querySelector('html').getAttribute('lang') || 'en';
      }
      _path = new Path(this.locales[locale]);
      str = _path.lookup(path);
      if (!str) {
        console.warn("No translation found for '" + path + "' for locale '" + locale + "'");
        return path;
      }
      return str.replace(/\{\{(.*?)\}\}/g, function(m, prop) {
        if (params[prop] !== void 0) {
          return params[prop].toString();
        } else {
          return '';
        }
      });
    };

    return i18n;

  })();

  window.i18n = i18n;

  /*
  --------------- /home/gszikszai/git/crystal/source/mvc/collection.coffee--------------
  */


  window.Collection = MVC.Collection = (function(_super) {

    __extends(Collection, _super);

    function Collection() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      Collection.__super__.constructor.apply(this, arguments);
      if (args.length > 0) {
        this.push.apply(this, args);
      }
      this;

    }

    Collection.prototype.transaction = function(fn) {
      var old;
      old = this.dup();
      this.silent = true;
      fn.call(this);
      this.silent = false;
      this._compare(old);
      return this;
    };

    Collection.prototype["switch"] = function(index1, index2) {
      if (!((0 <= index1 && index1 <= this.length - 1))) {
        return;
      }
      if (!((0 <= index2 && index2 <= this.length - 1))) {
        return;
      }
      this.transaction(function() {
        var x;
        x = this[index2];
        this[index2] = this[index1];
        return this[index1] = x;
      });
      return this;
    };

    Collection.prototype.splice = function() {
      var args, index, items, length, old, r,
        _this = this;
      index = arguments[0], length = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      old = this.dup();
      r = Collection.__super__.splice.apply(this, [index, length]);
      items = args.uniq().compact().filter(function(item) {
        return _this.indexOf(item) === -1;
      });
      items.unshift(index, 0);
      r = Collection.__super__.splice.apply(this, items);
      this._compare(old);
      return r;
    };

    Collection.prototype._compare = function(old) {
      var moves, n, removes,
        _this = this;
      if (!this.silent) {
        n = this.map(function(item, i) {
          if (old.indexOf(item) === -1) {
            return [item, i];
          } else {
            return false;
          }
        }).compact();
        moves = [];
        removes = [];
        old.map(function(item, i) {
          var index;
          index = _this.indexOf(item);
          if (index !== -1 && index !== i) {
            moves.push([i, index]);
          }
          if (index === -1) {
            return removes.push(i);
          }
        }).compact();
        return this.trigger('change', {
          removed: removes,
          added: n,
          moved: moves
        });
      }
    };

    return Collection;

  })(Array);

  ['push', 'unshift'].forEach(function(key) {
    return Collection.prototype[key] = function() {
      var args, items, old, r,
        _this = this;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      old = this.dup();
      items = args.uniq().compact().filter(function(item) {
        return _this.indexOf(item) === -1;
      });
      r = Array.prototype[key].apply(this, items);
      this._compare(old);
      return r;
    };
  });

  ['pop', 'shift', 'sort', 'reverse'].forEach(function(key) {
    return Collection.prototype[key] = function() {
      var args, old, r;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      old = this.dup();
      r = Array.prototype[key].apply(this, args);
      this._compare(old);
      return r;
    };
  });

  _ref = Utils.Evented.prototype;
  for (key in _ref) {
    value = _ref[key];
    Collection.prototype[key] = value;
  }

  /*
  --------------- /home/gszikszai/git/crystal/source/mvc/model.coffee--------------
  */


  window.Model = Model = (function(_super) {

    __extends(Model, _super);

    function Model(data) {
      var descriptor, _ref1;
      Object.defineProperty(this, '__properties__', {
        value: {},
        enumerable: false
      });
      _ref1 = this.properties;
      for (key in _ref1) {
        descriptor = _ref1[key];
        this._property(key, descriptor);
      }
      for (key in data) {
        value = data[key];
        if (Object.getOwnPropertyDescriptor(this, key)) {
          this[key] = value;
        }
      }
    }

    Model.prototype._property = function(name, value) {
      return Object.defineProperty(this, name, {
        get: function() {
          return this.__properties__[name];
        },
        set: function(val) {
          if (value instanceof Function) {
            val = value.call(this, val);
          }
          if (val !== this.__properties__[name]) {
            this.__properties__[name] = val;
            this.trigger('change');
            return this.trigger('change:' + name);
          }
        },
        enumerable: true
      });
    };

    return Model;

  })(Crystal.Utils.Evented);

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/audio.coffee--------------
  */


  window.Song = Song = (function(_super) {

    __extends(Song, _super);

    Song.prototype.properties = {
      title: {},
      cover: {},
      src: {},
      album: {},
      artist: {},
      playing: {}
    };

    function Song() {
      Song.__super__.constructor.apply(this, arguments);
      this.playing = false;
    }

    return Song;

  })(Model);

  window.AudioWrapper = AudioWrapper = (function(_super) {

    __extends(AudioWrapper, _super);

    function AudioWrapper(options) {
      this.next = __bind(this.next, this);

      this.update = __bind(this.update, this);

      var tag, _ref1,
        _this = this;
      _ref1 = options || {
        repeat: false,
        shuffle: false
      }, this.repeat = _ref1.repeat, this.shuffle = _ref1.shuffle;
      if ((tag = document.createElement('audio')).canPlayType) {
        if (tag.canPlayType('audio/mpeg')) {
          this.audio = tag;
          this.audio.preload = 'preload';
          this.audio.autobuffer = true;
          this.audio.volume = 0;
          this.addEvents();
          this.playing = null;
          this.playlist = new Collection;
          this.playlist.on('change', function(e, mutation) {
            var song, _i, _len, _ref2, _results;
            _ref2 = mutation.added;
            _results = [];
            for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
              song = _ref2[_i];
              _results.push(song[0].on('play', function() {
                return _this.play(song[0], true);
              }));
            }
            return _results;
          });
        }
      }
    }

    AudioWrapper.prototype.addEvents = function() {
      this.audio.addEventListener("timeupdate", this.update);
      return this.audio.addEventListener("ended", this.next);
    };

    AudioWrapper.prototype.update = function() {
      var duration, fraction, time;
      fraction = (time = this.audio.currentTime) / (duration = this.audio.duration);
      return this.trigger('update', fraction, time, duration);
    };

    AudioWrapper.prototype.check = function(obj) {
      return obj instanceof Song;
    };

    AudioWrapper.prototype.stop = function() {
      if (this.playing != null) {
        this.audio.pause();
        this.audio.src = null;
        this.playing.playing = false;
        this.playing = null;
        return this.trigger('idle');
      }
    };

    AudioWrapper.prototype.pause = function() {
      if (this.playing != null) {
        this.audio.pause();
        this.playing.playing = false;
        return this.trigger('pause');
      }
    };

    AudioWrapper.prototype.next = function() {
      var a;
      if (this.playing != null) {
        if (this.shuffle) {
          return this.play(this.playlist.sample);
        } else if ((a = this.playlist[this.playlist.indexOf(this.playing) + 1]) != null) {
          return this.play(a, true);
        } else if (this.repeat) {
          return this.play(this.playlist[0]);
        } else {
          return this.stop();
        }
      }
    };

    AudioWrapper.prototype.prev = function() {
      var a;
      if (this.playing != null) {
        if (this.shuffle) {
          return this.play(this.playlist.sample);
        } else if ((a = this.playlist[this.playlist.indexOf(this.playing) - 1]) != null) {
          return this.play(a, true);
        } else if (this.repeat) {
          return this.play(this.playlist.last);
        } else {
          return this.stop();
        }
      }
    };

    AudioWrapper.prototype.play = function(song, force) {
      if (force == null) {
        force = false;
      }
      if ((this.playing != null) && !force) {
        if (this.audio.paused) {
          this.audio.play();
          this.playing.playing = true;
          this.trigger('resume', song);
          return null;
        }
      }
      if (song != null) {
        if (typeof song === 'number') {
          song = this.playlist[song - 1];
        }
        if (song != null) {
          if (this.check(song)) {
            if (this.playlist.indexOf(song) === -1) {
              this.add(song);
            }
          }
        }
      } else {
        song = this.playlist[0];
      }
      if (song != null) {
        if (this.playing != null) {
          this.playing.playing = false;
        }
        this.playing = song;
        this.playing.playing = true;
        this.audio.src = this.playing.src;
        this.audio.play();
        return this.trigger('play', song);
      }
    };

    AudioWrapper.prototype.empty = function(obj) {
      this.stop();
      return this.playlist = new Collection();
    };

    AudioWrapper.prototype.add = function(obj) {
      if (this.check(obj)) {
        return this.playlist.push(obj);
      }
    };

    AudioWrapper.prototype.remove = function(obj) {
      var index;
      if (this.check(obj) && (index = this.playlist.indexOf(obj)) !== -1) {
        return this.playlist.remove$(obj);
      }
    };

    return AudioWrapper;

  })(Crystal.Utils.Evented);

  /*
  --------------- /home/gszikszai/git/crystal/source/types/keyboard-event.coffee--------------
  */


  SPECIAL_KEYS = {
    0: "\\",
    8: "backspace",
    9: "tab",
    12: "num",
    13: "enter",
    16: "shift",
    17: "ctrl",
    18: "alt",
    19: "pause",
    20: "capslock",
    27: "esc",
    32: "space",
    33: "pageup",
    34: "pagedown",
    35: "end",
    36: "home",
    37: "left",
    38: "up",
    39: "right",
    40: "down",
    44: "print",
    45: "insert",
    46: "delete",
    48: "0",
    49: "1",
    50: "2",
    51: "3",
    52: "4",
    53: "5",
    54: "6",
    55: "7",
    56: "8",
    57: "9",
    65: "a",
    66: "b",
    67: "c",
    68: "d",
    69: "e",
    70: "f",
    71: "g",
    72: "h",
    73: "i",
    74: "j",
    75: "k",
    76: "l",
    77: "m",
    78: "n",
    79: "o",
    80: "p",
    81: "q",
    82: "r",
    83: "s",
    84: "t",
    85: "u",
    86: "v",
    87: "w",
    88: "x",
    89: "y",
    90: "z",
    91: "cmd",
    92: "cmd",
    93: "cmd",
    96: "num_0",
    97: "num_1",
    98: "num_2",
    99: "num_3",
    100: "num_4",
    101: "num_5",
    102: "num_6",
    103: "num_7",
    104: "num_8",
    105: "num_9",
    106: "multiply",
    107: "add",
    108: "enter",
    109: "subtract",
    110: "decimal",
    111: "divide",
    124: "print",
    144: "num",
    145: "scroll",
    186: ";",
    187: "=",
    188: ",",
    189: "-",
    190: ".",
    191: "/",
    192: "`",
    219: "[",
    220: "\\",
    221: "]",
    222: "\'",
    224: "cmd",
    57392: "ctrl",
    63289: "num"
  };

  Object.defineProperty(KeyboardEvent.prototype, 'key', {
    get: function() {
      if (key = SPECIAL_KEYS[this.keyCode]) {
        return key;
      }
      return String.fromCharCode(this.keyCode).toLowerCase();
    }
    /*
    --------------- /home/gszikszai/git/crystal/source/utils/keyboard.coffee--------------
    */

  });

  window.Keyboard = Keyboard = (function() {

    Keyboard.prototype.handleKeydown = function(e) {
      var combo, delimeters, pressed, sc, _i, _len, _ref1, _results;
      delimeters = /-|\+|:|_/g;
      if (!e.cancelled) {
        combo = [];
        if (e.ctrlKey) {
          combo.push("ctrl");
        }
        if (e.shiftKey) {
          combo.push("shift");
        }
        if (e.altKey) {
          combo.push("alt");
        }
        combo.push(e.key);
        _results = [];
        for (sc in this) {
          method = this[sc];
          pressed = true;
          _ref1 = sc.split(delimeters);
          for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
            key = _ref1[_i];
            if (combo.indexOf(key) === -1) {
              pressed = false;
              break;
            }
          }
          if (pressed) {
            method.call(this);
            e.preventDefault();
            e.cancelled = true;
            e.stopPropagation();
            break;
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    };

    function Keyboard(focus) {
      var _this = this;
      this.focus = focus != null ? focus : false;
      this.handleKeydown = __bind(this.handleKeydown, this);

      document.addEventListener('keydown', function(e) {
        if (_this.focus) {
          if (document.first(":focus")) {
            return _this.handleKeydown(e);
          }
        } else {
          if (!document.first(':focus')) {
            return _this.handleKeydown(e);
          }
        }
      });
      if (typeof this.initialize === "function") {
        this.initialize();
      }
    }

    return Keyboard;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/utils/uri.coffee--------------
  */


  window.URI = Utils.URI = (function() {

    function URI(uri) {
      var m, parser, _ref1, _ref2;
      if (uri == null) {
        uri = '';
      }
      parser = document.createElement('a');
      parser.href = uri;
      if (!!(m = uri.match(/\/\/(.*?):(.*?)@/))) {
        _ref1 = m, m = _ref1[0], this.user = _ref1[1], this.password = _ref1[2];
      }
      this.host = parser.hostname;
      this.protocol = parser.protocol.replace(/:$/, '');
      if (parser.port === "0") {
        this.port = 80;
      } else {
        this.port = parser.port || 80;
      }
      this.hash = parser.hash.replace(/^#/, '');
      this.query = ((_ref2 = uri.match(/\?(.*?)(?:#|$)/)) != null ? _ref2[1].parseQueryString() : void 0) || {};
      this.path = parser.pathname.replace(/^\//, '');
      this.parser = parser;
      this;

    }

    URI.prototype.toString = function() {
      var uri;
      uri = this.protocol;
      uri += "://";
      if (this.user && this.password) {
        uri += this.user.toString() + ":" + this.password.toString() + "@";
      }
      uri += this.host;
      if (this.port !== 80) {
        uri += ":" + this.port;
      }
      if (this.path !== "") {
        uri += "/" + this.path;
      }
      if (Object.keys(this.query).length > 0) {
        uri += "?" + this.query.toQueryString();
      }
      if (this.hash !== "") {
        uri += "#" + this.hash;
      }
      return uri;
    };

    return URI;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/mvc/model-view.coffee--------------
  */


  window.ModelView = ModelView = (function() {

    function ModelView(model, view) {
      var args, binding, fn, fninit, selector, _ref1, _ref2, _ref3;
      this.model = model;
      this.view = view;
      this.__bindings__ = [];
      _ref1 = this.bindings;
      for (key in _ref1) {
        args = _ref1[key];
        if (!(args instanceof Array)) {
          args = [args];
        }
        _ref2 = key.split('|'), selector = _ref2[0], binding = _ref2[1];
        if ((fn = Bindings[binding])) {
          if ((fninit = Bindings["_" + binding])) {
            this.apply(fninit, selector.trim(), args);
          }
          this.__bindings__.push([selector.trim(), binding.trim(), args, fn]);
        }
      }
      _ref3 = this.events;
      for (key in _ref3) {
        fn = _ref3[key];
        this.view.delegateEvent(key, fn.bind(this));
      }
    }

    ModelView.prototype.apply = function(fn, selector, args) {
      var views;
      args = args.dup();
      views = selector === '.' ? [this.view] : this.view.all(selector);
      args.unshift(views);
      return fn.apply(this.model, args);
    };

    ModelView.prototype.render = function() {
      var args, binding, bobj, fn, selector, _i, _len, _ref1, _results;
      _ref1 = this.__bindings__;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        bobj = _ref1[_i];
        selector = bobj[0], binding = bobj[1], args = bobj[2], fn = bobj[3];
        _results.push(this.apply(fn, selector, args));
      }
      return _results;
    };

    return ModelView;

  })();

  /*
  --------------- /home/gszikszai/git/crystal/source/mvc/bindings.coffee--------------
  */


  window.Bindings = Bindings = (function() {

    function Bindings() {}

    Bindings._wrap = function(fn) {
      return function() {
        var args, els,
          _this = this;
        els = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return els.forEach(function(el) {
          args.unshift(el);
          return fn.apply(_this, args);
        });
      };
    };

    Bindings.define = function(key, value) {
      if (typeof key === 'string') {
        return this[key] = this._wrap(value);
      } else {
        this[key.name] = this._wrap(key.render);
        return this["_" + key.name] = this._wrap(key.initialize);
      }
    };

    return Bindings;

  })();

  Bindings.define('text', function(el, property) {
    return el.text = this[property];
  });

  Bindings.define('visible', function(el, property) {
    return el.css('display', this[property] ? 'block' : 'none');
  });

  Bindings.define('toggleClass', function(el, property, cls) {
    if (this[property]) {
      return el.classList.add(cls);
    } else {
      return el.classList.remove(cls);
    }
  });

  Bindings.define({
    name: 'value',
    render: function(el, property) {
      return el.value = this[property];
    },
    initialize: function(el, property) {
      var _this = this;
      return el.addEvent('input', function() {
        return _this[property] = el.value;
      });
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/app/env.coffee--------------
  */


  window.Platforms = {
    WEBSTORE: 1,
    NODE_WEBKIT: 2,
    WEB: 3
  };

  window.PLATFORM = window.location.href.match(/^chrome-extension\:\/\//) ? Platforms.WEBSTORE : 'require' in window ? Platforms.NODE_WEBKIT : Platforms.WEB;

  /*
  --------------- /home/gszikszai/git/crystal/source/app/app.coffee--------------
  */


  _wrap = function(name, app) {
    return function(data, fn) {
      var _results;
      if (data instanceof Object) {
        _results = [];
        for (key in data) {
          value = data[key];
          _results.push(app[name].call(app, key, value));
        }
        return _results;
      } else {
        return app[name].call(app, data, fn);
      }
    };
  };

  window.Application = Application = (function(_super) {

    __extends(Application, _super);

    function Application(root) {
      var win,
        _this = this;
      this.root = root != null ? root : document;
      this.logger = new ConsoleLogger;
      this.keyboard = new Keyboard;
      this.router = new History;
      window.addEvent('load', function() {
        return _this.trigger('load');
      });
      if (PLATFORM === Platforms.NODE_WEBKIT) {
        win = require('nw.gui').Window.get();
        win.on('minimize', function() {
          return _this.trigger('minimize');
        });
      }
    }

    Application.prototype.set = function(name, value) {
      switch (name) {
        case "logger":
          return this.logger = new value;
        default:
          return this[name] = value;
      }
    };

    Application.prototype.get = function(key, fn) {
      return this.router[key] = fn.bind(this);
    };

    Application.prototype.sc = function(key, fn) {
      return this.keyboard[key] = fn.bind(this);
    };

    Application.prototype.def = function(key, fn) {
      return this[key] = fn;
    };

    Application.prototype.event = function(key, fn) {
      return this.root.delegateEvent(key, fn.bind(this));
    };

    Application.prototype.on = function(name, fn) {
      if (name === 'end') {
        return window.onbeforeunload = fn;
      } else {
        return Application.__super__.on.apply(this, arguments);
      }
    };

    Application.prototype.subscribe = function(name, callback) {
      return Application.__super__.subscribe.call(this, name, callback.bind(this));
    };

    Application["new"] = function(func) {
      var context;
      this.app = new Application;
      context = {};
      for (key in this.app) {
        context[key] = _wrap(key, this.app);
      }
      func.call(context);
      return this.app;
    };

    return Application;

  })(Utils.Evented);

  /*
  --------------- /home/gszikszai/git/crystal/source/app/view.coffee--------------
  */


  /*
  --------------- /home/gszikszai/git/crystal/source/types/color.coffee--------------
  */


  window.Color = Color = (function() {

    function Color(color) {
      var hex, match;
      if (color == null) {
        color = "FFFFFF";
      }
      color = color.toString();
      color = color.replace(/\s/g, '');
      if ((match = color.match(/^#?([0-9a-f]{3}|[0-9a-f]{6})$/i))) {
        if (color.match(/^#/)) {
          hex = color.slice(1);
        } else {
          hex = color;
        }
        if (hex.length === 3) {
          hex = hex.replace(/([0-9a-f])/gi, '$1$1');
        }
        this.type = 'hex';
        this._hex = hex;
        this._alpha = 100;
        this._update('hex');
      } else if ((match = color.match(/^hsla?\((-?\d+),\s*(-?\d{1,3})%,\s*(-?\d{1,3})%(,\s*([01]?\.?\d*))?\)$/)) != null) {
        this.type = 'hsl';
        this._hue = parseInt(match[1]).clampRange(0, 360);
        this._saturation = parseInt(match[2]).clamp(0, 100);
        this._lightness = parseInt(match[3]).clamp(0, 100);
        this._alpha = parseInt(parseFloat(match[5]) * 100) || 100;
        this._alpha = this._alpha.clamp(0, 100);
        this.type += match[5] ? "a" : "";
        this._update('hsl');
      } else if ((match = color.match(/^rgba?\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})(,\s*([01]?\.?\d*))?\)$/)) != null) {
        this.type = 'rgb';
        this._red = parseInt(match[1]).clamp(0, 255);
        this._green = parseInt(match[2]).clamp(0, 255);
        this._blue = parseInt(match[3]).clamp(0, 255);
        this._alpha = parseInt(parseFloat(match[5]) * 100) || 100;
        this._alpha = this._alpha.clamp(0, 100);
        this.type += match[5] ? "a" : "";
        this._update('rgb');
      } else {
        throw 'Wrong color format!';
      }
    }

    Color.prototype.invert = function() {
      this._red = 255 - this._red;
      this._green = 255 - this._green;
      this._blue = 255 - this._blue;
      this._update('rgb');
      return this;
    };

    Color.prototype.mix = function(color2, alpha) {
      var c, item, _i, _len, _ref1;
      if (alpha == null) {
        alpha = 50;
      }
      if (!(color2 instanceof Color)) {
        color2 = new Color(color2);
      }
      c = new Color();
      _ref1 = ['red', 'green', 'blue'];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        item = _ref1[_i];
        c[item] = Math.round((color2[item] / 100 * (100 - alpha)) + (this[item] / 100 * alpha)).clamp(0, 255);
      }
      return c;
    };

    Color.prototype._hsl2rgb = function() {
      var h, i, l, rgb, s, t1, t2, t3, val;
      h = this._hue / 360;
      s = this._saturation / 100;
      l = this._lightness / 100;
      if (s === 0) {
        val = Math.round(l * 255);
        this._red = val;
        this._green = val;
        this._blue = val;
      }
      if (l < 0.5) {
        t2 = l * (1 + s);
      } else {
        t2 = l + s - l * s;
      }
      t1 = 2 * l - t2;
      rgb = [0, 0, 0];
      i = 0;
      while (i < 3) {
        t3 = h + 1 / 3 * -(i - 1);
        t3 < 0 && t3++;
        t3 > 1 && t3--;
        if (6 * t3 < 1) {
          val = t1 + (t2 - t1) * 6 * t3;
        } else if (2 * t3 < 1) {
          val = t2;
        } else if (3 * t3 < 2) {
          val = t1 + (t2 - t1) * (2 / 3 - t3) * 6;
        } else {
          val = t1;
        }
        rgb[i] = val * 255;
        i++;
      }
      this._red = Math.round(rgb[0]);
      this._green = Math.round(rgb[1]);
      return this._blue = Math.round(rgb[2]);
    };

    Color.prototype._hex2rgb = function() {
      value = parseInt(this._hex, 16);
      this._red = value >> 16;
      this._green = (value >> 8) & 0xFF;
      return this._blue = value & 0xFF;
    };

    Color.prototype._rgb2hex = function() {
      var x;
      value = this._red << 16 | (this._green << 8) & 0xffff | this._blue;
      x = value.toString(16);
      x = '000000'.substr(0, 6 - x.length) + x;
      return this._hex = x.toUpperCase();
    };

    Color.prototype._rgb2hsl = function() {
      var b, delta, g, h, l, max, min, r, s;
      r = this._red / 255;
      g = this._green / 255;
      b = this._blue / 255;
      min = Math.min(r, g, b);
      max = Math.max(r, g, b);
      delta = max - min;
      if (max === min) {
        h = 0;
      } else if (r === max) {
        h = (g - b) / delta;
      } else if (g === max) {
        h = 2 + (b - r) / delta;
      } else {
        if (b === max) {
          h = 4 + (r - g) / delta;
        }
      }
      h = Math.min(h * 60, 360);
      if (h < 0) {
        h += 360;
      }
      l = (min + max) / 2;
      if (max === min) {
        s = 0;
      } else if (l <= 0.5) {
        s = delta / (max + min);
      } else {
        s = delta / (2 - max - min);
      }
      this._hue = h;
      this._saturation = s * 100;
      return this._lightness = l * 100;
    };

    Color.prototype._update = function(type) {
      switch (type) {
        case 'rgb':
          this._rgb2hsl();
          return this._rgb2hex();
        case 'hsl':
          this._hsl2rgb();
          return this._rgb2hex();
        case 'hex':
          this._hex2rgb();
          return this._rgb2hsl();
      }
    };

    Color.prototype.toString = function(type) {
      if (type == null) {
        type = 'hex';
      }
      switch (type) {
        case "rgb":
          return "rgb(" + this._red + ", " + this._green + ", " + this._blue + ")";
        case "rgba":
          return "rgba(" + this._red + ", " + this._green + ", " + this._blue + ", " + (this.alpha / 100) + ")";
        case "hsl":
          return "hsl(" + this._hue + ", " + (Math.round(this._saturation)) + "%, " + (Math.round(this._lightness)) + "%)";
        case "hsla":
          return "hsla(" + this._hue + ", " + (Math.round(this._saturation)) + "%, " + (Math.round(this._lightness)) + "%, " + (this.alpha / 100) + ")";
        case "hex":
          return this.hex;
      }
    };

    return Color;

  })();

  ['red', 'green', 'blue'].forEach(function(item) {
    return Object.defineProperty(Color.prototype, item, {
      get: function() {
        return this["_" + item];
      },
      set: function(value) {
        this["_" + item] = parseInt(value).clamp(0, 255);
        return this._update('rgb');
      }
    });
  });

  ['lightness', 'saturation'].forEach(function(item) {
    return Object.defineProperty(Color.prototype, item, {
      get: function() {
        return this["_" + item];
      },
      set: function(value) {
        this["_" + item] = parseInt(value).clamp(0, 100);
        return this._update('hsl');
      }
    });
  });

  ['rgba', 'rgb', 'hsla', 'hsl'].forEach(function(item) {
    return Object.defineProperty(Color.prototype, item, {
      get: function() {
        return this.toString(item);
      }
    });
  });

  Object.defineProperties(Color.prototype, {
    hex: {
      get: function() {
        return this._hex;
      },
      set: function(value) {
        this._hex = value;
        return this._update('hex');
      }
    },
    hue: {
      get: function() {
        return this._hue;
      },
      set: function(value) {
        this._hue = parseInt(value).clampRange(0, 360);
        return this._update('hsl');
      }
    },
    alpha: {
      get: function() {
        return this._alpha;
      },
      set: function(value) {
        return this._alpha = parseInt(value).clamp(0, 100);
      }
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/types/unit.coffee--------------
  */


  window.Unit = Unit = (function() {

    Unit.UNITS = {
      px: true,
      em: true
    };

    function Unit(value, basePX) {
      if (value == null) {
        value = "0px";
      }
      if (basePX == null) {
        basePX = 16;
      }
      this.base = basePX;
      this.set(value);
    }

    Unit.prototype.toString = function(type) {
      if (type == null) {
        type = "px";
      }
      if (!(type in Unit.UNITS)) {
        return this._value + "px";
      }
      if (type === 'em') {
        return (this._value / this.base) + "em";
      } else {
        return this._value + "px";
      }
    };

    Unit.prototype.set = function(value) {
      var m, match, type, v;
      if ((match = value.match(/(\d+)(px|em)$/))) {
        m = match[0], value = match[1], type = match[2];
        v = parseFloat(value) || 0;
        if (type === 'em') {
          return this._value = parseInt(this.base * v);
        } else {
          return this._value = parseInt(v);
        }
      } else {
        throw 'Wrong Unit format!';
      }
    };

    return Unit;

  })();

  ['px', 'em'].forEach(function(type) {
    return Object.defineProperty(Unit.prototype, type, {
      get: function() {
        return this.toString(type);
      }
    });
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/types/function.coffee--------------
  */


  Object.defineProperties(Function.prototype, {
    delay: {
      value: function() {
        var args, bind, id, ms,
          _this = this;
        ms = arguments[0], bind = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
        if (bind == null) {
          bind = this;
        }
        return id = setTimeout(function() {
          _this.apply(bind, args);
          return clearTimeout(id);
        }, ms);
      }
    },
    periodical: {
      value: function() {
        var args, bind, ms,
          _this = this;
        ms = arguments[0], bind = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
        if (bind == null) {
          bind = this;
        }
        return setInterval(function() {
          return _this.apply(bind, args);
        }, ms);
      }
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/dom/node-list.coffee--------------
  */


  Object.defineProperties(NodeList.prototype, {
    forEach: {
      value: function(fn, bound) {
        var i, node, _i, _len;
        if (bound == null) {
          bound = this;
        }
        for (i = _i = 0, _len = this.length; _i < _len; i = ++_i) {
          node = this[i];
          fn.call(bound, node, i);
        }
        return this;
      }
    },
    map: {
      value: function(fn, bound) {
        var node, _i, _len, _results;
        if (bound == null) {
          bound = this;
        }
        _results = [];
        for (_i = 0, _len = this.length; _i < _len; _i++) {
          node = this[_i];
          _results.push(fn.call(bound, node));
        }
        return _results;
      }
    },
    pluck: {
      value: function(property) {
        var node, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = this.length; _i < _len; _i++) {
          node = this[_i];
          _results.push(node[property]);
        }
        return _results;
      }
    },
    include: {
      value: function(el) {
        var node, _i, _len;
        for (_i = 0, _len = this.length; _i < _len; _i++) {
          node = this[_i];
          if (node === el) {
            return true;
          }
        }
        return false;
      }
    },
    first: {
      get: function() {
        return this[0];
      }
    },
    last: {
      get: function() {
        return this[this.length - 1];
      }
    }
  });

  /*
  --------------- /home/gszikszai/git/crystal/source/dom/document-fragment.coffee--------------
  */


  Object.defineProperties(DocumentFragment.prototype, {
    children: {
      get: function() {
        return this.childNodes;
      }
    },
    remove: {
      value: function(el) {
        var node, _i, _len, _ref1;
        _ref1 = this.childNodes;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          node = _ref1[_i];
          if (node === el) {
            this.removeChild(el);
          }
        }
        return this;
      }
    }
  });

  DocumentFragment.Create = function() {
    return document.createDocumentFragment();
  };

}).call(this);
 
 })(window.Crystal={Utils:{}})
