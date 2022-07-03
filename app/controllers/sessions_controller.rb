class SessionsController < ApplicationController
    before_action :require_no_authentication, only: [:new, :create]
    before_action :require_authentication, only: [:destroy]

    def new

    end

    def create
        user = User.find_by email: params[:email]
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            session[:name] = user.name
            redirect_to root_path
            flash[:success]="Добро пожаловать #{user.name}!"
        else
            render :error, status: :unprocessable_entity
        end
    end

    def destroy
        session.delete :user_id
        session.delete :name
        redirect_to root_path, status: 303
    end
end
