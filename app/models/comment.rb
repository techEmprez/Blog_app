class Comment < ApplicationRecord
  # after_save :post_comment_counter
  belongs_to :post
  belongs_to :author, class_name: 'User'
  after_destroy :update_comment_counter
  after_save :update_comment_counter

  private

  def update_comment_counter
    post.update(comments_counter: post.comments.count)
  end
end