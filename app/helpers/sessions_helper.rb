module SessionsHelper

    #Logs in the given user
    def log_in(user)
        session[:user_id] = @user.id
    end
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_login
        return head(:forbidden) unless session.include?(:user_id)
    end
end