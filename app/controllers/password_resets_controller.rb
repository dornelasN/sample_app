class PasswordResetsController < ApplicationController
  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update]
  before_action :check_expiration,  only: [:edit, :update]  # Case 1

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password information."
      redirect_to root_url
    else
      flash[:danger] = "Email address not found."
      render 'new'
    end
  end

  def edit
  end

  #TODO:
  # consider 4 cases:
  # 1 - An expired password reset: before accessing update, check_expiration with before_action
  # 2 - A failed update due to an invalid password: #render 'edit'
  # 3 - A failed update (which initially looks 'successful') due to an empty password and confirmation
  # 4 - A successful update
  def update
    if params[:user][:password].empty?                  #Case (3)
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)          #Case (4)
      log_in @user
      flash[:success] = "Password has been reset."
      @user.update_attribute(:reset_digest, nil)
      redirect_to @user
    else
      render 'edit'                                     #Case (2)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  # Before filters
    def get_user
      @user = User.find_by(email: params[:email].downcase)
    end

  # Confirms a valid user
  def valid_user
    if (!@user || !@user.activated? || !@user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Checks expiration of reset token.
  # If reset_token was sent for more than 2 hours, redirect to new_password_resest_url
  # Where user will be able to send a new email with a reset_link
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end