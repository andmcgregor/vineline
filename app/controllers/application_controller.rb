class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

		def days_in_month(month, year)
   		if month == 2 && Date.gregorian_leap?(year)
        29
      else
        [31,28,31,30,31,30,31,31,30,31,30,31][month - 1]
      end
		end

		helper_method :current_user, :days_in_month
end
