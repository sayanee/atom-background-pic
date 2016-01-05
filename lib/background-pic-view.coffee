{CompositeDisposable} = require 'atom'

module.exports =
class BackgroundPicElement extends HTMLElement
  constructor: ->
    @attach()

  serialize: ->

  destroy: ->
    @stop()
    @disposables.dispose()

  attach: ->
    pic = document.createElement('div')
    pic.classList.add('pic')

    paneView = atom.views.getView(atom.workspace.getActivePane())
    paneView.querySelector('.item-views').appendChild(pic)

  detach: ->
    @remove()

  start: ->
    attach()

  stop: ->
    @remove()
