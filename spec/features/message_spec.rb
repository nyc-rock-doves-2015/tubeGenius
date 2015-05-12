require 'rails_helper'

RSpec.feature 'Messaging', :type => :feature do

  let!(:user) { User.create(name: "username", password: 'password', password_confirmation: 'password')}

  scenario "User sends a new message" do
   page.set_rack_session(user_id: user.id)

   visit conversations_path
     click_link "Start conversation"
     fill_in "message[subject]", :with => "test subject"
     fill_in "message[body]", :with => "test test body"
     # select "admin", :from => 'recipients'
     click_button "Send"

     expect(page).to have_text('test subject')
  end

  scenario "User views all messages" do
   page.set_rack_session(user_id: user.id)

   visit conversations_path
     expect(page).to have_text('Start conversation')
  end


end
