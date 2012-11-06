
Application["new"](function() {
  this.event({
    'click:input[type=button]': function() {
      return document.first('form');
    }
  });
  return this.on('load', function() {
    return console.log('loaded');
  });
});
