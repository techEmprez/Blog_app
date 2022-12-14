class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
    { @user => @user, @posts => @posts }
  end

  def show
    @post = Post.find(params[:id])
  end
end
