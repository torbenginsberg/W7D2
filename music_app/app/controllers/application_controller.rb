class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?

    private
    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !!current_user
    end

    def current_user
        if session[:session_token]
            @current_user ||= User.find_by(session_token: session[:session_token])
        else
            nil
        end
    end

    def logout_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_no_user!
        redirect to new_session_url if current_user #redirect somewhere else later
    end

    def require_user!
        redirect to new_session_url if current_user.nil?
    end
end
