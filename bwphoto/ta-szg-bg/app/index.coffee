Application.new ->
  @event
    'click:input[type=button]': ->
      document.first('form')
  @on 'load', ->
    console.log 'loaded'