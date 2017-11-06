require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nelson)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  #if not logged in, user should be redirected to login_url if accessing edit_user_path
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  #if not logged in, user should be redirected to login_url if trying to update an user
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }

    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
