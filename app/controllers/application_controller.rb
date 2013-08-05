class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

  	COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

		def days_in_month(month, year)
   		return 29 if month == 2 && Date.gregorian_leap?(year)
   		COMMON_YEAR_DAYS_IN_MONTH[month]
		end
		helper_method :days_in_month
end
