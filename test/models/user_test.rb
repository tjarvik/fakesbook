require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:joe)
    @already_friend = users(:mama)
    @not_yet_friend = users(:papa)
    @never_friend = users(:donald)
  end

  test "feed should contain posts from correct people" do
    
    #include friends
    
    #don't include non-friends
    
    #don't include self
    
  end

  test "friend list should include correct people" do
    @friends = @user.friends_list
    #include friends
    assert @friends.include?(@already_friend)
    #don't include non-friends
    assert_not @friends.include?(@never_friend)
    #don't include self
    assert_not @friends.include?(@user)
  end
  
end
