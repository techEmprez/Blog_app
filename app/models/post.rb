has_many :comments, foreign_key: 'post_id'
  after_save :update_post_counter
  
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
