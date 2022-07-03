class ApplicationController < ActionController::Base
    include ErrorHandling
    include Pagy::Backend

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present? 
    end

    def user_signed_in?
        current_user.present?
    end

    def require_no_authentication
        return if !user_signed_in?
        redirect_to root_path
        flash[:warning] = "Вы уже вошли в систему!"
    end

    def require_authentication
        return if user_signed_in?
        redirect_to root_path
        flash[:warning] = "Вы не вошли систему!"
    end

    def owner?(obj)
        session[:user_id] == obj.user_id ? true : false
    end

    helper_method :current_user, :user_signed_in?, :owner?
end
