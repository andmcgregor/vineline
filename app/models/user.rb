class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :username, :full_name, :location, :avatar, :description
  has_many :vines, :dependent => :destroy, :order => 'filmed ASC'

  validates :username, :uniqueness => true

  def self.from_omniauth(auth)
    user = find_by_uid(auth["uid"]) || create_from_omniauth(auth)
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_secret = auth["credentials"]["secret"]
    user.save
    user
  end

	def self.create_from_omniauth(auth)
	  user = User.new
		user.provider = auth["provider"]
		user.uid = auth["uid"]
		user.username = auth["info"]["nickname"]
    user.full_name = auth["info"]["name"]
    user.location = auth["info"]["location"]
    user.avatar = auth["info"]["image"].sub("_normal", "")
    user.description = auth["info"]["description"]
    user
	end

  def twitter
    @twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
  end
end