class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :notifications

  validates :title, presence: true
  validates :url, presence: true
end