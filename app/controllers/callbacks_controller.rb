class CallbacksController < ApplicationController

  def index
    user_info_hash = request.env['omniauth.auth']['info']
    @user = User.find_by(email: user_info_hash['email'])
    if @user
      session_in!(@user)
      redirect_to user_path(@user)
    else
      @new_user = User.create!(name: user_info_hash['name'], 
                              email: user_info_hash['email'], 
                              password: request.env['omniauth.auth']['credentials']['token'][0..71],
                              password_confirmation: request.env['omniauth.auth']['credentials']['token'][0..71])
      session_in!(@new_user)
      redirect_to user_path(@new_user)
    end
  end
  
end