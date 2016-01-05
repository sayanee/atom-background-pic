{CompositeDisposable} = require 'atom'
Pics = require './pics'

module.exports =
class BackgroundPicElement extends HTMLElement
  constructor: ->
    today = new Date()
    todayDate = today.getDate() - 1
    @pic = document.createElement('div')
    @pic.style.backgroundImage = 'url(' + Pics[ todayDate ] + ')'
    @pic.classList.add('pic')
    console.log(Pics[ todayDate ])

    @disposables = new CompositeDisposable
    @disposables.add atom.workspace.onDidAddPane => @updateVisibility()
    @disposables.add atom.workspace.onDidDestroyPane => @updateVisibility()
    @disposables.add atom.workspace.onDidChangeActivePaneItem => @updateVisibility()

  updateVisibility: ->
    if @shouldBeAttached()
      @attach()
    else
      @detach()

  shouldBeAttached: ->
    atom.workspace.getPanes().length is 1 and not atom.workspace.getActivePaneItem()?

  serialize: ->

  destroy: ->
    @stop()
    @disposables.dispose()

  attach: ->
    paneView = atom.views.getView(atom.workspace.getActivePane())
    paneView.querySelector('.item-views').appendChild(@pic)

  detach: ->
    @pic.remove()
