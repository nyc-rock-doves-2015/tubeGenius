class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  has_secure_password
  acts_as_messageable
  has_many :notifications

  include Gravtastic
  gravtastic

  validates :name, uniqueness: true

  has_many :videos
  has_many :comments
  has_many :message_users
  has_many :messages, through: :message_users

  def mailboxer_email(object)
    email
  end

end