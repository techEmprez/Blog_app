class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_likes_counter

  validates :author, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :post, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
