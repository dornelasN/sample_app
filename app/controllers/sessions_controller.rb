class SessionsController < ApplicationController
  def new
  end

  # creates a session by retrieving user from db
  # logs in to the website in case user is true and password authentication is valid and
  # the account has been activated, it hasn't give warning message for the activation link
  # returns error message and re-renders login page otherwise
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "Account not activated. \n Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # create an error message.
      flash.now[:danger] = "Invalid email/password combination!"
      render 'new'
    end
  end

  # detroys the session for logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
