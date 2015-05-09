class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :url, presence: true

  def static_comments
    self.comments.where(start_time: nil, end_time: nil)
  end
  
end