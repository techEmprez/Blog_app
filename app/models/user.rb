class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true, length: { minimum: 3, maximum: 150 }

  def recent_post
    posts.order('created_at Desc').limit(3)
  end
end
