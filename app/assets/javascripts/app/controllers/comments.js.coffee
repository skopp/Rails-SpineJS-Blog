$ = jQuery
Comment = App.Comment

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Comment.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('comments/new')

  back: ->
    @navigate '/comments'

  submit: (e) ->
    e.preventDefault()
    comment = Comment.fromForm(e.target).save()
    @navigate '/comments', comment.id if comment

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Comment.find(id)
    @render()
    
  render: ->
    @html @view('comments/edit')(@item)

  back: ->
    @navigate '/comments'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/comments'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Comment.find(id)
    @render()

  render: ->
    @html @view('comments/show')(@item)

  edit: ->
    @navigate '/comments', @item.id, 'edit'

  back: ->
    @navigate '/comments'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Comment.bind 'refresh change', @render
    Comment.fetch()
    
  render: =>
    comments = Comment.all()
    @html @view('comments/index')(comments: comments)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/comments', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/comments', item.id
    
  new: ->
    @navigate '/comments/new'
    
class App.Comments extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/posts/#{post_id}/comments/new':       'new'
    '/posts/#{post_id}/comments/:id/edit':  'edit'
    '/posts/#{post_id}/comments/:id':       'show'
    '/posts/#{post_id}/comments':           'index'
    
  default: 'index'
  className: 'stack comments'