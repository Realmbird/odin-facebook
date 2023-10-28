class CommentsController < ApplicationController
   def create
    @commentable = GlobalID::Locator.locate(params[:comment][:global_id])
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
        flash[:notice] = "Added Comment."
        redirect_to posts_path
    else
        flash[:error] = "Unable to add Comment."
        redirect_to posts_path
    end
   end

   def show
        @comment = Comment.find(params[:id])
   end
    private

    def comment_params
        params.require(:comment).permit(:body, :user_id)
    end
end
