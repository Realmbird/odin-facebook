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

    def update
        @friendship = Friendship.where(user_id: params[:friend_id], friend_id: current_user.id)
        if @friendship.update(confirmed: true)
            flash[:notice] = "sent friendship"
            redirect_to current_user
        else
            flash[:error] = "didn't update"
            redirect_to root_url
        end
    end
    
    def destroy
        @friendship = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship."
        redirect_to current_user
    end 
end
