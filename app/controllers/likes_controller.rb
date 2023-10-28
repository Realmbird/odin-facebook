class LikesController < ApplicationController
    def create
        if User.exists?
            likable  = GlobalID::Locator.locate(params[:global_id])
            @like = Like.new(likable_id: likable.id, likable_type: likable.class.name, user_id: current_user.id)
            if @like.save
                flash[:notice] = "Added Like."
                redirect_to request.fullpath
            else
                flash[:error] = "Unable to add Like."
                redirect_to request.fullpath
            end
        end
    end
end
