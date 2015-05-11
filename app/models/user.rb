class User < ActiveRecord::Base
  has_secure_password

  include Gravtastic

  gravtastic :default => 'https://d13yacurqjgara.cloudfront.net/users/17619/screenshots/318757/400.png'

  validates :name, uniqueness: true

  has_many :videos
  has_many :comments
  has_many :message_users
  has_many :messages, through: :message_users

end