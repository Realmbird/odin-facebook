class AddUserRefToFriendships < ActiveRecord::Migration[7.0]
  def change
    add_reference :friendships, :friend
    add_reference :friendships, :user
  end
end
