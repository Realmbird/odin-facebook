class UsersController < ApplicationController
    def index
        @users = User.where.not(id: current_user.id).select { |user| user.friendships.empty? && user.inverse_friendships.empty? }
    end
    def show
        @user = current_user
    end
    def edit
        @user = current_user
    end

end
