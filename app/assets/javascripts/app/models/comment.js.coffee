class App.Comment extends Spine.Model
  @configure 'Comment', 'author', 'body', 'post_id'
  @extend Spine.Model.Ajax