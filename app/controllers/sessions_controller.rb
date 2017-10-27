class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if user.nil?
      flash.now[:error] = ["invalid"]
      #redirect_to #somewhere
    else
      login!(user)
      redirect_to user_url
    end
  end


  def destroy
    logout!
    #redirect_to #somewhere
  end
end
