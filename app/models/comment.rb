class Comment < ApplicationRecord
    # belongs to user is created by or author only one of them
    belongs_to :user
    # is associated with a post or a comment comments can be added onto many different things
    belongs_to :commentable, polymorphic: true
    # A comment can have many comments
    has_many :comments, as: :commentable
    # A comment can have many likes  
    has_many :likes, as: :likable
end
