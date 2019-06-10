class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :notifications_count, if: :signed_in?

    def notifications_count
      @notifications = current_user.requests_list.count
    end
    
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    
end
