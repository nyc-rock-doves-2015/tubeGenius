class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      session_in!(@user)
      redirect_to user_path(@user.id)
    else
      set_flash "Bad sign up information"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.find(params[:id])
  end

end