class SessionsController < ApplicationController
  def new
  end

  # creates a session by retrieving user from db
  # logs in to the website in case user is true and password authentication is valid
  # returns error message and re-renders login page otherwise
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      # create an error message.
      flash.now[:danger] = "Invalid email/password combination!"
      render 'new'
    end
  end

  # detroys the session for logout
  def destroy
    log_out
    redirect_to root_url
  end
end
