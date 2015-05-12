class User < ActiveRecord::Base
  has_secure_password
  acts_as_messageable

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