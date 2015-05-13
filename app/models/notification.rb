class Notification < ActiveRecord::Base
    belongs_to :commentable
    belongs_to :comments
    belongs_to :users
end
