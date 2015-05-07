class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_flash(msg)
    flash[:notice] = msg
  end

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def session_in!(user)
    session[:user_id] = user.id
  end

  def session_out!
    session[:user_id] = nil
  end

end
