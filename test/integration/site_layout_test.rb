require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nelson)
  end

  test "layout links for non-logged-in users" do
    #test title and links to different paths in root_path
    get root_path
    assert_template 'static_pages/home'
    assert_select "title", full_title
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    
    #test titles in each of the paths
    get help_path
    assert_select "title", full_title("Help")
    get about_path
    assert_select "title", full_title("About")
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get login_path
    assert_select "title", full_title("Login")
  end

  test "layout links for logged-in users" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "title", full_title
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)

    #test titles of logged_in users page
    get users_path
    assert_select "title", full_title("All users")
    get user_path(@user)
    assert_select "title", full_title(@user.name)
    get edit_user_path(@user)
    assert_select "title", full_title("Edit User")
  end
end
