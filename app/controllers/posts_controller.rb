class PostsController < ApplicationController
  before_action :set_user, only: %i[index show]

  def show
    @post = @user.posts.find(params[:id])
  end

  def index
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 2)
  end

  def new; end

  def create
    title = params[:title]
    body = params[:body]
    author = current_user
    @post = Post.new(title:, body:, author:)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = "Post couldn't be created"
      render 'new'
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(post.author)
    else
      flash.now[:alert] = "Post couldn't be deleted"
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
