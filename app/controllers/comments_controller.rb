class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment =Comment.new(comment_params)
    @comment.author = current_user
    @comment.post_id = (params[:post_id])
    if @comment.save
      redirect_to user_post_path(current_user.id, @comment.post_id)
    else
      render plain: @comment.errors.messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
