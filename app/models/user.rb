class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # adding username devise
  attr_writer :login
  validate :validate_username

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # Adding providers
  devise :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
         user = User.create(name: data['name'],
            email: data['email'],
            username: access_token.info.name,
            password: Devise.friendly_token[0,20]
         )
     end
    user
end
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # relationships of models
  
  has_many :friendships, -> {where(confirmed: false)}
  has_many :friends, through: :friendships
  has_many :inverse_friendships, -> {where(confirmed: false)}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user


  has_many :posts
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  
  def profile_pic 
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}"
  end


  def true_friends
    #finds all friendships where you sent it which you have accepted then finds who accepted
    friendships_sent = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    #finds all friendships you accepted it which you have accepted then finds who sent it to you 
    friendships_got =  Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    # all friends with confirmed is true
    friend_list = friendships_sent + friendships_got
    User.where(id: friend_list)
  end
  def find_likes
    Like.where(user_id: id)
  end
end


