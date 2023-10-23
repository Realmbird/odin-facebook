class UsersController < ApplicationController
    def index
        @users = User.where.not(id: current_user.id)
    end
    def show
        @user = current_user
    end
    def edit
        @user = current_user
    end

end
