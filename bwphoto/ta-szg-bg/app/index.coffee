class ImageModel extends Model
  properties:
    title: {}
    camera: {}
    date: {}
    author: {}
    processed_picture: {}

class ImageView extends ModelView
  bindings:
    '.|text':'title'
  constructor: ->
    super
    img = Element.create("img")
    img.src = @model.processed_picture

    document.body.append img
    @model.on 'change', @render.bind @

Application.new ->
  @event
    'click:input[type=button]': ->
      url = document.first('[name=url]').value
      data =
        title: document.first('[name=title]').value
        filename: url
      r = new Request "/image"
      r.post data, (response) ->
        console.log response.body

  @on 'load', ->

    list = new UI.List
      element: 'li'
      prepare: (el,item) ->
        new ImageView(item, el).render()

    document.body.append list.base

    setInterval ->
      r = new Request "/image"
      r.get {}, (response) ->
        a = new Collection
        for image in response.body
          image.processed_picture = "data:image/png;base64,"+image.processed_picture
          a.push new ImageModel(image)
        list.bind a

    , 4000