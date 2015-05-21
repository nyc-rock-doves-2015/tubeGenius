class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :notifications

  validates :title, presence: true
  validates :url, presence: true

  def thumbnail_url
    regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    "http://img.youtube.com/vi/" + self.url.match(regex)[1] + "/0.jpg"
  end
end