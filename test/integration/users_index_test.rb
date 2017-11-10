require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:nelson)
    @non_admin = users(:testUser)
  end

  # Test users index page as a logged_in @admin.
  # checks for 2 <div class='pagination'> and for users names and 'delete' links
  # also verifies that a user is destroyed by the DELETE action
  test "index including pagination, only show activated users" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      else
        assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  # Check there are no "DELETE" links if the logged_in user is a non-admin
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
