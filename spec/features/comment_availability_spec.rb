require 'rails_helper'

RSpec.feature 'Comment Availability', :type => :feature do

  let!(:user) { create(:user) }
  let!(:video) { create(:video) }
  let!(:video_permission) { create(:video, :user_id => 10, :availability => "Personal") }
  let!(:video_owner) { create(:video, :user_id => user.id, :availability => "Personal") }

end