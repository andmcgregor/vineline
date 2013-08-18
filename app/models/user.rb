class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :username, :full_name, :location, :avatar, :description, :oauth_token, :oauth_secret
  has_many :vines, dependent: :destroy, order: 'filmed ASC'

  validates :username, :full_name, :avatar, :uid, :oauth_token, :oauth_secret, presence: true
  validates :uid, uniqueness: true

  def self.from_omniauth(auth)
    user = find_by_uid(auth["uid"]) || create_from_omniauth(auth)
    user.update_attributes(oauth_token: auth["credentials"]["token"],
                           oauth_secret: auth["credentials"]["secret"])
    user
  end

	def self.create_from_omniauth(auth)
	  User.new(provider: auth["provider"],
        		 uid: auth["uid"],
        		 username: auth["info"]["nickname"],
             full_name: auth["info"]["name"],
             location: auth["info"]["location"],
             avatar: auth["info"]["image"].sub("_normal", ""),
             description: auth["info"]["description"])
	end

  def twitter
    @twitter ||= Twitter::Client.new(oauth_token: oauth_token, oauth_token_secret: oauth_secret)
  end
end