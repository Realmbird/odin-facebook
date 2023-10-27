class LikesController < ApplicationController
    def create
        if User.exists?
            @like = current_user.likes.build(likable_id: params[:likable_id], likable_type: params[:likable_type], user_id: current_user.id)
            if @like.save
                flash[:notice] = "Added Like. #{ params[:likable_type]}"
                redirect_to root_url
            else
                flash[:error] = "Unable to add Like."
                redirect_to root_url
            end
        end
    end
end
