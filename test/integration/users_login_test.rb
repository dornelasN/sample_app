require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "invalid login information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?

    #visit another page and check if flash is still there.
    get root_path
    assert_not flash.any?
  end
end
