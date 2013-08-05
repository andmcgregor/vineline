class SessionsController < ApplicationController
	def new
	end

	def create
		auth = request.env["omniauth.auth"]
		user = User.from_omniauth(auth)
		FetchVinesWorker.perform_async(user.username)
		session[:user_id] = user.id
		redirect_to user_path(current_user.username)
		if user.last_pull == nil
			flash[:notice] = "Welcome! Vines posted on your Twitter account will be added soon."
		else
			flash[:notice] = "Welcome back!"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end
