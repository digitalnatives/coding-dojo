$ = jQuery.sub()
Bwimage = App.Bwimage

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Bwimage.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('bwimages/new')

  back: ->
    @navigate '/bwimages'

  submit: (e) ->
    e.preventDefault()
    bwimage = Bwimage.fromForm(e.target).save()
    @navigate '/bwimages', bwimage.id if bwimage

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Bwimage.find(id)
    @render()
    
  render: ->
    @html @view('bwimages/edit')(@item)

  back: ->
    @navigate '/bwimages'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/bwimages'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Bwimage.find(id)
    @render()

  render: ->
    @html @view('bwimages/show')(@item)

  edit: ->
    @navigate '/bwimages', @item.id, 'edit'

  back: ->
    @navigate '/bwimages'

class Index extends Spine.Controller
  elements:
    '#list': 'list'
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Bwimage.bind 'refresh change', @render
    Bwimage.fetch()
    
  render: =>
    bwimages = Bwimage.all()
    @html @view('bwimages/index')(bwimages: bwimages)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/bwimages', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/bwimages', item.id
    
  new: ->
    @navigate '/bwimages/new'

  add_new: (params = {title: 'title', author: 'author', camera: 'camera' })->
    Spine.Ajax.disable =>
      item = Bwimage.create params
      @list.append @view('bwimages/item')(item)
    
class App.Bwimages extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/bwimages/new':      'new'
    '/bwimages/:id/edit': 'edit'
    '/bwimages/:id':      'show'
    '/bwimages':          'index'
    
  default: 'index'
  className: 'stack bwimages'
