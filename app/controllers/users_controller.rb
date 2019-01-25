class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:user]
      @user = User.new(user_params)
      if @user.save
        set_session_id
      end
    end
  end

  def show
    @user = User.find(session[:user_id])
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_session_id
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

end
