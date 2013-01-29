class App.Comment extends Spine.Model
  @configure 'Comment', 'author', 'body', 'post_id'

  @url: ->
    "posts/#{post_id}/comments"

  @belongsTo 'post', 'App.Post'
  
  @extend Spine.Model.Ajax