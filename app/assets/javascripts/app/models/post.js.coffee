class App.Post extends Spine.Model
  @configure 'Post', 'title', 'body', 'comments'

  @hasMany 'comments', 'App.Comment'

  @extend Spine.Model.Ajax