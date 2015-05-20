class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  acts_as_messageable
  has_many :notifications

  include Gravtastic
  gravtastic
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :videos
  has_many :comments
  has_many :message_users
  has_many :messages, through: :message_users

  def mailboxer_email(object)
    email
  end

end