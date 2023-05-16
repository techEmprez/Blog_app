class Comment < ApplicationRecord
  # after_save :post_comment_counter
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_save :update_comments_counter

  # private

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def post_comment_counter
    post.increment!(:comments_count)
  end
end
