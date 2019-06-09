class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_friends, only: [:show, :edit]

  # GET /users
  # GET /users.json
  def index
    if params[:friend_toggle_id]
      if params[:method] == "add friend"
        current_user.add_friend(params[:friend_toggle_id])
        flash.now[:notice] = "Friend request sent."
      elsif params[:method] == "cancel"
        current_user.cancel_request(params[:friend_toggle_id])
        flash.now[:notice] = "Friend request canceled."
      else
        current_user.remove_friend(params[:friend_toggle_id])
      end
    end
    @users = current_user.everybody_else
    @friends = current_user.friends_list
    @friend_statuses = current_user.friend_statuses
    @button_texts = set_button_texts(@friend_statuses)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def notify
    if params[:request_id]
      request = FriendRequest.find(params[:request_id])
      if request.requested_id == current_user.id #should be true unless spoofed
        current_user.confirm_request(request.requester_id)
        request.destroy
        flash.now[:notice] = "You have been added to #{request.requester.name}'s harem."
      end
    end
    @requests = current_user.requests_list
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def set_friends
      @friends = @user.friends_list
    end

    def set_button_texts(friend_statuses)
      button_texts = Hash.new('add friend')
      friend_statuses.each do |id, status|
          button_texts[id] = 'remove friend' if status == 'friends'
          button_texts[id] = 'cancel' if status == 'request pending'
      end
      button_texts
    end

          
end
