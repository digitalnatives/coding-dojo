var ImageModel, ImageView,
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

  function ImageView() {
    var img;
    ImageView.__super__.constructor.apply(this, arguments);
    img = Element.create("img");
    img.src = this.model.processed_picture;
    document.body.append(img);
    this.model.on('change', this.render.bind(this));
  }

  return ImageView;

})(ModelView);

Application["new"](function() {
  this.event({
    'click:input[type=button]': function() {
      var data, r, url;
      url = document.first('[name=url]').value;
      data = {
        title: document.first('[name=title]').value,
        filename: url
      };
      r = new Request("/image");
      return r.post(data, function(response) {
        return console.log(response.body);
      });
    }
  });
  return this.on('load', function() {
    var list;
    list = new UI.List({
      element: 'li',
      prepare: function(el, item) {
        return new ImageView(item, el).render();
      }
    });
    document.body.append(list.base);
    return setInterval(function() {
      var r;
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
        return list.bind(a);
      });
    }, 4000);
  });
});
