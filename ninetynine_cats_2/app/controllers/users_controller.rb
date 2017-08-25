class UsersController < ApplicationController

  before_action :require_current_user!, except: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Bad Input"]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
