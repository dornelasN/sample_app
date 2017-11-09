class AccountActivationsController < ApplicationController

  # find user by email parameter
  # if user is true, not activated, and its activation_token is authenticated, then:
  # update activated and activated_at attributes, log_in theu ser and redirect to profile page
  # else flash a danger message and redirect to home page
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link."
      redirect_to 
    end
  end
end
