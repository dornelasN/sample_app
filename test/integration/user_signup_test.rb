require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do 
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" }}
    end
    
    #test to make sure the new users page is rendered and the messages containers exist
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do 
    get signup_path
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: {  name: "Valid User",
                                          email: "user@valid.com",
                                          password: "password",
                                          password_confirmation: "password" } }
    end
    # arrange to follow redirect after form submission: rendering 'users/show'
    follow_redirect!

    # verify thath she show template renders following a successful signup
    assert_template 'users/show' 

    assert_not flash.empty?
  end
end
