class FriendshipsController < ApplicationController

    def create
        # friend user exists?
        if User.exists?(id: params[:friend_id])
            @friendship = current_user.friendships.build(friend_id: params[:friend_id], user_id: current_user.id)
            if @friendship.save
                flash[:notice] = "Added friend."
                redirect_to root_url
            else
                flash[:error] = "Unable to add friend."
                redirect_to root_url
            end
        end
    end
    
    def destroy
        @friendship = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship."
        redirect_to current_user
    end
end
