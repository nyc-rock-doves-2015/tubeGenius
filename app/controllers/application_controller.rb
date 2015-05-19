class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :session_in!
  helper_method :unread_messages, :unread_notifications, :thumbnail_url

  def unread_messages
    current_user.mailbox.inbox({:read => false}).count if current_user
  end

  def unread_notifications
    current_user.notifications.where({:read => false}).count if current_user
  end

  def set_flash(msg)
    flash[:notice] = msg
  end

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def session_in!(user)
    session[:user_id] = user.id
  end

  def session_out!
    session[:user_id] = nil
  end

  def authenticate_user!(return_point = request.url)
    if !current_user
      set_return_point(return_point)
      redirect_to root_path
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

  def thumbnail_url(video_url)
    regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    "http://img.youtube.com/vi/" + video_url.match(regex)[1] + "/0.jpg"
  end
end


















