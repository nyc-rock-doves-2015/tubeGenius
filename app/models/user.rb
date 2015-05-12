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


#   #Returning any kind of identification you want for the model
# def name
#   return "hello"
# end
# #Returning the email address of the model if an email should be sent for this object (Message or Notification).
# #If no mail has to be sent, return nil.
def mailboxer_email(object)
  email
end
end