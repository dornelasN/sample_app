require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup 
    @user = users(:nelson)
    #using @user.micropost.build already makes the association between the micropost and user
    #the micropost user_id is set to the @user.id automatically
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "    "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  # Verify that the first mocropost in the DB is the same as the most_recent micropost fixture 
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
