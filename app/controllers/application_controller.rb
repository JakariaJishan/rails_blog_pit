class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :time_ago
    def time_ago (date)
        current_date = Time.zone.now
        target_date = date
        time_diff = (current_date - target_date).to_i
        seconds = time_diff.to_i
        minutes = (time_diff / 60).to_i
        hours = (time_diff / 3600).to_i
        days = (time_diff / (3600 * 24)).to_i
        months = (time_diff / (3600 * 24 * 30)).to_i
        years = (time_diff / (3600 * 24 * 365)).to_i

        if seconds < 60
            "a few seconds ago"
        elsif minutes == 1
            return "1 minute ago"
        elsif minutes < 60
            return "#{minutes} minutes ago"
        elsif hours == 1
            return "1 hour ago"
        elsif hours < 24
            return "#{hours} hours ago"
        elsif days == 1
            return "1 day ago"
        elsif days < 30
            return "#{days} days ago"
        elsif months == 1
            return "1 month ago"
        elsif months < 12
            return "#{months} months ago"
        elsif years == 1
            return "1 year ago"
        else
            "#{years} years ago"
        end
    end
protected
def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar, :date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :date, :password, :password_confirmation, :current_password])
end

end
