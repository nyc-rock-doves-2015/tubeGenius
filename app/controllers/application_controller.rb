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

  def authenticate_user!(return_point = request.url)
    unless current_user
      set_return_point(return_point)
      redirect_to signin_path
    end
  end

  def set_return_point(path, overwrite = false)
    if overwrite || session[:return_point].blank?
      session[:return_point] = path
    end
  end

  def return_point
    session[:return_point] || root_path
  end
end
