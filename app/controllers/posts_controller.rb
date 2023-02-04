class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_post_url(@user, @post)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:author_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
