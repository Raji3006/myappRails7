class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = User.find(params[:id])
    end

    def index
        @user = User.all
    end

    def new 
        @user = User.new 
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "Your account as been updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            flash[:notice] = "Welcome to the App"
            redirect_to 'home_logged_in'
        else
            render 'new'
        end
    end

    def destroy
        @user = current_user.users.find(params[:id])
        @user.destroy
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number, :address, :pincode)
    end
    
end
