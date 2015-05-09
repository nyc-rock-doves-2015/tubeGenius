require 'rails_helper'

describe Video do

  before(:each) do
    @video = build(:video)
  end

  it "should have valid factory" do
    expect(@video).to be_valid
  end
end