class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :friendships
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
    # User.where("name = ?", "Mama")#placeholder
  end

  def everybody_else
    User.where.not("id = ?", self.id)
  end

end
