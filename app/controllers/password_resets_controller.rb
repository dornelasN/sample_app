class PasswordResetsController < ApplicationController
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

  # TODO:
  def edit
  end
end