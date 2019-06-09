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
    assert_select 'tr', /mama.*friends.*remove/i
   
  end

  test "non-friend should have add friend button in index" do
    get users_path
    assert_select 'tr', /donald.*not\sfriends.*add/i
  end

  test "pending friend should have cancel button in index" do
    @user.add_friend(@not_yet_friend.id)
    get users_path
    assert_select 'tr', /papa.*pending.*cancel/i
  end

  test "requesting a friend should result in a request notification" do
    assert_difference('FriendRequest.count', 1) do
      @user.add_friend(@not_yet_friend.id)
    end
    assert_not @user.friends?(@not_yet_friend)
  end

  test "accepting a friend request should result in a friendship" do
    @user.add_friend(@not_yet_friend.id)
    assert_difference('Friendship.count', 2) do
      @not_yet_friend.confirm_request(@user.id)
    end
    assert @user.friends?(@not_yet_friend)
  end

end
