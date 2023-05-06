class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  validates :name, presence: true, length: { maximum: 30 }
  validates :bio, presence: true, length: { minimum: 15 }
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def recent_post
    posts.order('created_at Desc').limit(3)
  end
end
