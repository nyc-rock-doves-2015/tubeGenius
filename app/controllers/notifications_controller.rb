class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order('created_at DESC')
    @unread_notifs = []
    @notifications.each do |notification|
      @unread_notifs << notification if notification.read == false
      notification.update_attribute(:read, true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to :back
  end
end