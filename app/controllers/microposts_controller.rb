class MicropostsController < ApplicationController
  # Since microposts are accessed through associated users, both CREATE and DESTROY require users
  # to be logged in
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
  end

  def destroy
  end
end
