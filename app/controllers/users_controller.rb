class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if request.xhr?
      render 'users/_profile', layout: false
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session_in!(@user)
      redirect_to user_path(@user.id)
    else
      set_flash "Bad sign up information"
      redirect_to new_user_path
    end
  end

    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end