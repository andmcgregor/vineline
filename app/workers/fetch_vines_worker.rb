class FetchVinesWorker
	include Sidekiq::Worker

	sidekiq_options :retry => false

	def perform(un)
		vines = []
    tweets = []
    user = User.find_by_username(un)

    first_request = user.twitter.user_timeline(user.username, count: 200, exclude_replies: true, include_rts: false)
    first_request.each do |tweet|
      tweet.urls.each do |url|
        if url.expanded_url.include?("vine.co/v/") && user.vines.exists?(:video_url => "#{url.expanded_url}") == false
          tweets << tweet
        end
      end
    end
    max_id = first_request.last.id - 1

    last_response_upto = first_request.last.id

    15.times do
      unless last_response_upto < user.pull_upto.to_i
        response = user.twitter.user_timeline(user.username, max_id: max_id, count: 200, exclude_replies: true, include_rts: false)
        response.each do |tweet|
          tweet.urls.each do |url|
            if url.expanded_url.include?("vine.co/v/") && user.vines.exists?(:video_url => "#{url.expanded_url}") == false
              tweets << tweet
            end
          end
        max_id = response.last.id - 1
        last_response_upto = response.last.id
        end
      end
    end

    user.update_attribute(:pull_upto, first_request.first.id.to_s)

    tweets.each do |tweet|
      tweet.urls.each do |url|
        vine_page = HTTParty.get(url.expanded_url.to_s)

        vine_thumbnail = /property="twitter:image"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s).captures.first if /property="twitter:image"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s) != nil
        vine_video_url = /property="twitter:player:stream"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s).captures.first if /property="twitter:player:stream"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=]+)/.match(vine_page.to_s) != nil
        vine_description = /property="twitter:description"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=|'|\s|!]+)/.match(vine_page.to_s).captures.first if /property="twitter:description"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=|'|\s|!]+)/.match(vine_page.to_s) != nil
        
        if /property="twitter:description"\s+content="([a-z|A-Z|0-9|:|\/|.|\-|_|?|=|'|\s|!]+)/.match(vine_page.to_s) != nil
          if user.vines.exists?(:video_url => "#{vine_video_url}") == false
            user.vines.create! do |vine|
              vine.post_id = tweet.id.to_s
              vine.thumbnail = vine_thumbnail
              vine.url = url.expanded_url
              vine.video_url = vine_video_url
              vine.description = vine_description
              vine.filmed = tweet.created_at.to_s
              # location - add this later, is it even possible to have location in a tweet posted from the vine client?
            end
          end
        end
      end     
    end 
    
    user.update_attribute(:last_pull, DateTime.now) # this not working?
	end

end