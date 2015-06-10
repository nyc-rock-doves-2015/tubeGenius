class WelcomeController < ApplicationController

  def index
    redirect_to videos_path unless !current_user
  end

end