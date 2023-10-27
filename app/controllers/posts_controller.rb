class PostsController < ApplicationController
    def new 
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "Added Post."
            redirect_to @post
        else
            flash[:error] = "Unable to add Post."
            redirect_to :new, status: :unprocessable_entity
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            flash[:notice] = "Updated Post."
            redirect_to @post
        else
            flash[:error] = "Post update failed"
            render :edit, status: :unprocessable_entity
        end    
    end

    def show
        @post = Post.find(params[:id])
    end

    def index
        @post = Post.all.where(user_id: current_user.id)
    end
    
    private

    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
