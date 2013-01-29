class PostsController < ApplicationController

  respond_to :html, :json, :js

  def index
    @posts = Post.all
    respond_with @posts, :include => :comments
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    respond_with post: @post, comments: @comments
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.save
    respond_with @post
  end

  def update
    @post = Post.find(params[:id])
    respond_with @post
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with @post
  end
end
