class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  # define will paginate per page globally so it is used for tests as well
  WillPaginate.per_page = 10 

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}, Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User #{user.name} deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters
    
    # Confirm a logged_in_user
    def logged_in_user 
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # Confirms the correct user is logged_in
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms that the current_user is an admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
