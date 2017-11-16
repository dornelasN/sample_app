require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
  end

  # Since microposts are accessed through associated users, both CREATE and DESTROY require users
  # to be logged in

  # redirect non-logged-in users trying to CREATE a micropost towards login_url
  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  # redirect non-logged-in users trying to DESTROY a micropost towards login_url
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end
end
