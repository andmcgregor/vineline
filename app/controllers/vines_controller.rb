class VinesController < ApplicationController
	def create
		if current_user
			AddVineWorker.perform_async(params["vine"]["vine_url"], current_user.username)
		end
		flash[:notice] = "Vine will be added shortly!"
		redirect_to user_path(current_user.username)
	end
	def edit
		@vines = current_user.vines.reverse
	end
	def destroy
		if current_user.vines.find(params[:id])
			vine = current_user.vines.find(params[:id])
			vine.delete
		end
		flash[:notice] = "Vine deleted!"
		redirect_to edit_path
	end
end
