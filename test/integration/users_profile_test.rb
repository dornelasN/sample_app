require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:nelson)
  end

  test "profile display" do
    # visit user profile page
    get user_path(@user)
    # asserts that the request 'users/show' template was rendered
    assert_template 'users/show'
    # check page title
    assert_select 'title', full_title(@user.name)
    # check user's name inside a h1 heading tag
    assert_select 'h1', text: @user.name
    # check for an img tag with class gravatar inside a h1 heading tag
    assert_select 'h1>img.gravatar'
    # check for microposts.count somewhere on the HTML source of the page
    assert_match @user.microposts.count.to_s, response.body
    # check for following stats 
    assert_select 'div.stats'
    # check for a pagination <div>
    assert_select 'div.pagination', count: 1
    # check for the every micropost's content somewhere on the HTML source of the page
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
