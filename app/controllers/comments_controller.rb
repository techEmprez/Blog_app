class CommentsController < ApplicationController
  before_action :set_user, only: %i[index show]
  before_action :set_post, only: %i[index show new create edit update destroy]

  def new; end

  def index
    @comments = @post.comments.paginate(page: params[:page], per_page: 2)
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def create
    body = comment_params
    @comment = Comment.new(body:, post: @post, author: current_user)
    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = "Comment couldn't be created"
      render 'new'
    end
  end

  def update; end

  def destroy
    comment = @post.comments.find(params[:id])
    if comment.destroy
      flash.now[:success] = 'Comment deleted successfully'
    else
      flash.now[:alert] = "Comment couldn't be deleted"
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:body)
  end
end