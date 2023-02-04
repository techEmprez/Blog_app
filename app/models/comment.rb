class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_save :update_comments_counter

  # private

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
