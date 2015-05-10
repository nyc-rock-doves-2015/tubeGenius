require 'rails_helper'

describe User do

  before(:each) do
    @user = build(:user)
  end

  it "should have valid factory" do
    expect(@user).to be_valid
  end

  it "is invalid without a name" do
    expect{create(:user, :name => nil)}.to raise_error
  end

  it "is invalid without a password" do
    expect{create(:user, :password => nil)}.to raise_error
  end

end