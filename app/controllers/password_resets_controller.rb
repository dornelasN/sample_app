class PasswordResetsController < ApplicationController
  before_action :get_user,    only: [:edit, :update]
  before_action :valid_user,  only: [:edit, :update]

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
  # 1 - An expired password reset
  # 2 - A failed update due to an invalid password.
  # 3 - A failed update (which initially looks 'successful') due to an empty password and confirmation
  # 4 - A successful update
  def update
  end

  private

    def get_user
      @user = User.find_by(email: params[:email].downcase)
    end

    # Confirms a valid user
    def valid_user
      if (!@user || !@user.activated? || !@user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

end