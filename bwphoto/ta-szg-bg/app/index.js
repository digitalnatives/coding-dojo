var ImageModel, ImageView, Layer, request, showLayer,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

ImageModel = (function(_super) {

  __extends(ImageModel, _super);

  function ImageModel() {
    ImageModel.__super__.constructor.apply(this, arguments);
  }

  ImageModel.prototype.properties = {
    title: {},
    camera: {},
    date: {},
    author: {},
    processed_picture: {}
  };

  return ImageModel;

})(Model);

ImageView = (function(_super) {

  __extends(ImageView, _super);

  ImageView.prototype.bindings = {
    '.|text': 'title'
  };

  ImageView.prototype.events = {
    'click': function() {
      return showLayer(this);
    }
  };

  function ImageView() {
    ImageView.__super__.constructor.apply(this, arguments);
    this.model.on('change', this.render.bind(this));
  }

  return ImageView;

})(ModelView);

Layer = (function(_super) {

  __extends(Layer, _super);

  function Layer() {
    Layer.__super__.constructor.apply(this, arguments);
  }

  Layer.prototype.show = function() {
    console.log(this);
    return this.view.css('display', 'block');
  };

  return Layer;

})(ModelView);

showLayer = function(item) {
  return layer.show();
};

request = function(data) {
  var r;
  r = new Request("/image");
  return r.post(data, function(response) {
    switch (response.body.status) {
      case 200:
        document.first("#success").css('display', 'block');
        return setTimeout(function() {
          return document.first("#success").css('display', 'none');
        }, 2000);
      case 500:
        document.first("#error").css('display', 'block');
        return setTimeout(function() {
          return document.first("#error").css('display', 'none');
        }, 2000);
    }
  });
};

Application["new"](function() {
  this.event({
    'click:input[type=button]': function() {
      var data, file, reader, url;
      file = document.first('[name=file]');
      data = {
        title: document.first('[name=title]').value
      };
      if (file.files.length > 0) {
        reader = new FileReader();
        reader.onload = function(e) {
          console.log(e);
          data.picture = e.target.result.split(";").pop();
          data.filename = file.files[0].name;
          return request(data);
        };
        return reader.readAsDataURL(file.files[0]);
      } else {
        url = document.first('[name=url]').value;
        data.filename = url;
        return request(data);
      }
    }
  });
  this.def('update', function() {
    var r,
      _this = this;
    r = new Request("/image");
    return r.get({}, function(response) {
      var a, image, _i, _len, _ref;
      a = new Collection;
      _ref = response.body;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        image = _ref[_i];
        image.processed_picture = "data:image/png;base64," + image.processed_picture;
        a.push(new ImageModel(image));
      }
      return _this.list.bind(a);
    });
  });
  return this.on('load', function() {
    var _this = this;
    window.layer = new Layer(null, document.first("#layer"));
    this.list = new UI.List({
      element: 'li',
      prepare: function(el, item) {
        return new ImageView(item, el).render();
      }
    });
    document.body.append(this.list.base);
    this.update();
    return setInterval(function() {
      return _this.update();
    }, 4000);
  });
});
