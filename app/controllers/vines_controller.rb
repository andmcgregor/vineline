class VinesController < ApplicationController
  def new
  end

  def create
    AddVineWorker.perform_async(params["vine"]["vine_url"], current_user.username)
    flash[:notice] = "Vine will be added shortly!"
    redirect_to user_path(current_user.username)
  end

  def edit
    @vines = current_user.vines.reverse
  end

  def destroy
    current_user.vines.find(params[:id]).delete
    flash[:notice] = "Vine deleted!"
    redirect_to edit_path
  end
end
