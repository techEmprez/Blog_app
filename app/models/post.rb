class Post < ApplicationRecord
  after_save :update_posts_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def fetch_recent_comments
    comments.last(5)
  end

  # private

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
