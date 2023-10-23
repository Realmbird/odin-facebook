class Post < ApplicationRecord
    # A post belongs to a user
    belongs_to :user
    # A post can have many comments and likes
    has_many :comments, as: :commentable
    has_many :likes, as: :likable
end
