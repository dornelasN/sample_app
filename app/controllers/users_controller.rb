class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  # if saving the new created user is successfull, redirect to show user page 
  # flashing a welcome message, if failed, render the new user page with error messages
  def create
    @user = User.new(user_params)
    if @user.save 
      log_in @user
      flash[:success] = "#{@user.name}, welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
