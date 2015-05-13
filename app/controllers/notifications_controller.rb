class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    @notifications.each do |notification|
      notification.update_attribute(:read, true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to :back
  end
end