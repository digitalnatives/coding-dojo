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
  events:
    'click': ->
      showLayer @
  constructor: ->
    super
    #img = Element.create("img")
    #img.src = @model.processed_picture
    #document.body.append img
    @model.on 'change', @render.bind @

class Layer extends ModelView
  constructor: ->
    super
  show: ->
    console.log @
    @view.css 'display', 'block'

showLayer = (item)->
  layer.show()

request = (data)->
  r = new Request "/image"
  r.post data, (response) ->
    switch response.body.status
      when 200
        document.first("#success").css 'display', 'block'
        setTimeout ->
           document.first("#success").css 'display', 'none'
        ,2000
      when 500
        document.first("#error").css 'display', 'block'
        setTimeout ->
           document.first("#error").css 'display', 'none'
        ,2000

Application.new ->
  @event
    'click:input[type=button]': ->
      file = document.first('[name=file]')
      data =
        title: document.first('[name=title]').value
      if file.files.length > 0
        reader = new FileReader()
        reader.onload = (e) ->
          console.log e
          data.picture = e.target.result.split(";").pop()
          data.filename = file.files[0].name
          request data
        reader.readAsDataURL file.files[0]
      else
        url = document.first('[name=url]').value
        data.filename = url
        request data

  @def 'update', ->
    r = new Request "/image"
    r.get {}, (response) =>
      a = new Collection
      for image in response.body
        image.processed_picture = "data:image/png;base64,"+image.processed_picture
        a.push new ImageModel(image)
      @list.bind a

  @on 'load', ->
    window.layer = new Layer(null,document.first("#layer"))
    @list = new UI.List
      element: 'li'
      prepare: (el,item) ->
        new ImageView(item, el).render()

    document.body.append @list.base
    @update()
    setInterval =>
      @update()

    , 4000