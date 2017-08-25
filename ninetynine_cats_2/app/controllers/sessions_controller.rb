class SessionsController < ApplicationController

  before_action :require_no_user!, only: [:create, :new]

  def new #sign in
    render :new
  end

  def create #logging in
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if @user.nil?
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    else
      login_user!(@user)
      redirect_to cats_url
    end
  end


  def destroy #logging out
    logout_user!
    redirect_to new_session_url
  end


  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
