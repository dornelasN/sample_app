require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nelson)
    @second_user = users(:testUser)
  end

  # redirect users to login page if trying to access users_path
  test "should redirect to index when not logged in" do
    get users_path
    assert_redirected_to login_url
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

  # verify that the admin attribute is not editable through the web as it is not in the
  # list of permitted parameters in user_params
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@second_user)
    assert_not @second_user.admin?
    patch user_path(@second_user), params: { user: {  password: '',
                                                      password_confirmation: '',
                                                      admin: true } }
    assert_not @second_user.reload.admin?
  end

  #if logged in as userX, user should be redirected to home page when trying to edit userY info
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@second_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  #if logged in as userX, user should be redirected to home page when trying to update userY info
  test "should redirect update when logged in as wrong user" do
    log_in_as(@second_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url    
  end

  # users who are not logged in should be redirected to log in page when trying to issue
  # a DELETE request directly to the destroy action
  test "should redirect destroy when not logged in" do
    # assert that the delete expression does not change the User.count after the block
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@second_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
