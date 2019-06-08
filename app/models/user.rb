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

end
