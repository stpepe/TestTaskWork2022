class UsersController < ApplicationController
    before_action :require_no_authentication

    def new
        @user = User.new 
    end

    def create
        @user = User.new user_params 
        if @user.save
            session[:user_id] = @user.id
            session[:name] = @user.name
            redirect_to root_path
            flash[:success]="Добро пожаловать #{@user.name}!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
