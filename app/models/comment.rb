class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { maximum: 100 }

  def post_comment_counter
    post.update(comments_counter: post.comments.count)
  end
end
