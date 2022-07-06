class UsersController < ApplicationController
    before_action :require_no_user!, only: [:new, :create]

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user) #temporary, will prob redirect elsewhere
        else
            #show error with flash?
            flash.now[:errors]
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def show
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end

end