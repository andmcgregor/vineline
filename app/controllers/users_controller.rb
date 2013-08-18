class UsersController < ApplicationController
	def new
	end

	def create
	end

	def show
		@user = User.find_by_username(params[:id])

		if @user.vines.count >= 1
			@most_recent = @user.vines.last.filmed
			vines = []

			if params[:year] != nil && params[:month] != nil && params[:day] != nil
				start_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
				end_date = start_date.end_of_day
			elsif params[:year] != nil && params[:month] != nil
				start_date = DateTime.new(params[:year].to_i, params[:month].to_i, 1)
				end_date = start_date.end_of_month
			elsif params[:year] != nil
				start_date = DateTime.new(params[:year].to_i, 1, 1)
				end_date = start_date.end_of_year
			else
				start_date = DateTime.new(@most_recent.year, @most_recent.month, 1)
				end_date = start_date.end_of_month
			end

			@user.vines.where("filmed >= ? AND filmed <= ?", start_date, end_date).each do |vine|
				vines << [vine.video_url, vine.description, [vine.filmed.year, vine.filmed.month, vine.filmed.day]]
			end

			dates = Hash.new
			@user.vines.each do |vine|
				year_str = vine.filmed.year.to_s
				month_str = vine.filmed.month.to_s
				day = vine.filmed.day

				if dates[year_str] == nil
					dates[year_str] = { month_str => [day] }
				elsif dates[year_str][month_str] == nil
					dates[year_str][month_str] = [day]
				elsif dates[year_str][month_str].include?(day) == false
					dates[year_str][month_str] << day
				end
			end

			gon.vineline = vines
			gon.vineline_count = vines.count
			gon.dates = dates
			@dates = dates # this exists only to know what years to print
		gon.username1 = @user.username

			gon.avatar = @user.avatar
		else
			#no vines exist
		end
	end

	def add
	end
end

