require 'spec_helper'

RSpec.feature 'New video', :type => :feature do
  scenario "User creates a new video" do
    visit "/video/new"
      fill_in "Title", :with => "Test Title"
      click_button "Create Video"

      expect(page).to have_text("Test Title")
  end
end