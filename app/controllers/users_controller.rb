class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.save
    login!(@user)
    redirect_to user_url
  end

  def show
    @user = User.find_by(username: params[:username])
    render :show
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
