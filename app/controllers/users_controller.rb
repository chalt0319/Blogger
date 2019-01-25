class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # raise params.inspect
    if params[:user]
      if @user = User.find_by(username: params[:user][:username])
        # raise params.inspect
        if @user.authenticate(params[:user][:password])
          set_session_id
        else
          cannot_find_account
        end
      else
        @user = User.new(user_params)
        if @user.save
          set_session_id
        else
          cannot_create_account
        end
      end
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def login
    @user = User.new
    render "users/login"
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_session_id
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def cannot_find_account
    flash[:alert] = "We cannot find your account in our system... Please try again."
    redirect_to login_path
  end

  def cannot_create_account
    flash[:alert] = "Cannot create account with those credentials. Please try again."
    redirect_to new_user_path
  end

end
