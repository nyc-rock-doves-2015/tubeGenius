class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :notifications

  validates :title, presence: true, length: { maximum: 255 }

  VALID_YOUTUBE_REGEX = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"\'>]+)/
  validates :url, presence: true, length: { maximum: 255 },
                    format: { with: VALID_YOUTUBE_REGEX }
end