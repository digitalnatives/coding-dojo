# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

window.Client = class Client
  constructor: ->
    @client = new Faye.Client("http://#{window.location.host}/faye")
    @client.subscribe "/photos/updated", (data) ->
      window.app.bwimages.index.add_new(data)

jQuery ->
  window.client = new Client

