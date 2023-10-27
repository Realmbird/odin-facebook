class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :friendships, -> {where(confirmed: false)}
         has_many :friends, through: :friendships
         has_many :inverse_friendships, -> {where(confirmed: false)}, class_name: "Friendship", foreign_key: "friend_id"
         has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :posts
  has_many :comments, as: :commentable
  has_many :likes, as: :likable

  def true_friends
    #finds all friendships where you sent it which you have accepted then finds who accepted
    friendships_sent = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    #finds all friendships you accepted it which you have accepted then finds who sent it to you 
    friendships_got =  Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    # all friends with confirmed is true
    friend_list = friendships_sent + friendships_got
    User.where(id: friend_list)
  end
end
