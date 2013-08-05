class AddVineWorker
	include Sidekiq::Worker

	sidekiq_options :retry => false

	def perform(vine_url, current_user)
		user = User.find_by_username(current_user)

		if user.vines.exists?(:video_url => "#{vine_url}") == false

			vine_page = HTTParty.get(vine_url)

    	vine_thumbnail = /property="twitter:image"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s).captures.first if /property="twitter:image"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s) != nil
    	vine_video_url = /property="twitter:player:stream"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s).captures.first if /property="twitter:player:stream"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s) != nil
    	vine_description = /property="twitter:description"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=|'|\s|!]+)/.match(vine_page.to_s).captures.first if /property="twitter:description"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=|'|\s|!]+)/.match(vine_page.to_s) != nil
      vine_date = /\/v\/thumbs\/(\d{4})\/(\d{2})\/(\d{2})/.match(vine_page.to_s) if /vine.co\/v\/thumbs\/(\d{4})\/(\d{2})\/(\d{2})/.match(vine_page.to_s) != nil
    	# only create if all above are found
      if /property="twitter:player:stream"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s) != nil
    		user.vines.create! do |vine|
      		vine.thumbnail = vine_thumbnail
      		vine.url = vine_url
      		vine.video_url = vine_video_url
          vine.description = vine_description
          vine.filmed = DateTime.new(vine_date[1].to_i, vine_date[2].to_i, vine_date[3].to_i)
      		# location - add this later, is it even possible to have location in a tweet posted from the vine client?
    		end
    	end
    end
	end
end