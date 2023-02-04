class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 3)
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

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @user.posts_counter -= 1
    @post.destroy
    @user.save
    flash[:notice] = 'Post deleted successfully'
    redirect_to user_posts_path(@user)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:author_id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :likes_counter, :comments_counter)
  end
end
