class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :get_friends, only: [:index, :show]

  # GET /users
  # GET /users.json
  def index
    if params[:friend_toggle_id]
      toggle_friend(@user, params[:friend_toggle_id])
    end
    @users = everybody_else(@user)
    @friend_statuses = get_friend_statuses(@user)
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
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def everybody_else(user)
      User.where.not("id = ?", user.id)
    end

    def get_friends
      #@friends = User.joins(:friendships).where(friendships: user)
      @friends = User.where("email = ?", "eep@eep.com")#placeholder
    end

    def get_friend_statuses(user)
      friend_statuses = Hash.new('not_friends')
      @friends.find_each do |friend|
        friend_statuses[friend.id] = 'friends'
      end
      friend_statuses
    end

    def toggle_friend(user, friend_id)

      flash.now[:notice] = "Friend request sent"
    end
end
