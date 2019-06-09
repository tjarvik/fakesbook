require 'test_helper'

class FriendRequestsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:joe)
    @already_friend = users(:mama)
    @not_yet_friend = users(:papa)
    @never_friend = users(:donald)
    sign_in @user
  end
  
  test "friend should have unfriend button in index" do
    get users_path
    assert_select 'tr', /mama.*remove/i
   
  end

  test "non-friend should have add friend button in index" do
    get users_path
    assert_select 'tr', /donald.*add/i
  end

  test "requesting a friend should result in a request notification" do
    
  end

  test "accepting a friend request should result in a friendship" do

  end

end
