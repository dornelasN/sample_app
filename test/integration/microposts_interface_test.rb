require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:nelson)
  end

  test "microposts interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This is a test micropost"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, picture: picture } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    first_micropost = @user.microposts.paginate(page: 1).first
    assert first_micropost.picture?
    # Delete post
    assert_select 'a', text: 'delete'
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  # Verify the number of microposts on the sidebar for users with 0, 1, or more microposts
  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # user with zero microposts
    other_user = users(:testUser)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "One micropost") 
    get root_path
    assert_match "#{other_user.microposts.count} micropost", response.body
  end
end
