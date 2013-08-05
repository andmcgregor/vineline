class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :username, :full_name, :location, :avatar, :description
  has_many :vines, :dependent => :destroy, :order => 'filmed ASC'

  validates :username, :uniqueness => true

  def self.from_omniauth(auth)
    user = where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_secret = auth["credentials"]["secret"]
    user.save!
    user
  end

	def self.create_from_omniauth(auth)
		  user = User.create!
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.username = auth["info"]["nickname"]
      user.full_name = auth["info"]["name"]
      user.location = auth["info"]["location"]
      user.avatar = auth["info"]["image"].sub("_normal", "")
      user.description = auth["info"]["description"]
		  user.save!
      user
	end

  def twitter
    # something like: if Twitter.rate_limit_status.remaining_hits > 1
    @twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
  end
end