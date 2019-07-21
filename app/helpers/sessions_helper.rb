module SessionsHelper

    #Logs in the given user
    def log_in(user)
        session[:user_id] = @user.id
    end
    
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def require_login
        return head(:forbidden) unless session.include?(:user_id)
    end
end