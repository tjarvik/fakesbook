class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: 'User'

  has_many :friend_requests, foreign_key: 'requested_id'
  has_many :sent_friend_requests, foreign_key: 'requester_id'
  has_many :requested_friends, through: :friend_requests, 
    foreign_key: "requester_id", class_name: "User"
  has_many :requesting_friends, through: :friend_requests, 
    foreign_key: "requested_id", class_name: "User"

  has_many :posts

  def friends_list
    User.joins(:friendships).where("friend_id = ?", self.id)
  end

  def everybody_else
    User.where.not("id = ?", self.id)
  end

  def friends?(other_user)
    Friendship.where("user_id = ? AND friend_id = ?", self.id, other_user.id).any?
  end

  def add_friend(friend_id)
    Friendship.create!(user_id: self.id, friend_id: friend_id)
    Friendship.create!(user_id: friend_id, friend_id: self.id)
  end

  def remove_friend(friend_id)
    friendship1 = Friendship.where("user_id = ? AND friend_id = ?", self.id, friend_id).first
    friendship1.destroy
    friendship2 = Friendship.where("user_id = ? AND friend_id = ?", friend_id, self.id).first
    friendship2.destroy
  end
end
