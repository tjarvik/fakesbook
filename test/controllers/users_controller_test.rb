require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:joe)
    sign_in @user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
   # assert_difference('User.count') do
    #  post users_url, params: { user: { name: 'zoop', email: 'zoop@nowhere.com', password: 'foobaz', password_confirmation: 'foobaz' } }
    #end

    #assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: 'zoop' } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user and associated items" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    #associated posts are destroyed
      
    #associated comments are destroyed
       
    #associated likes are destroyed
       
    #associated friendships are destroyed
     
    #associated friend requests are destroyed
       
    assert_redirected_to users_url
  end


end
