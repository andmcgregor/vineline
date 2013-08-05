class Vine < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user

  validates :video_url, :uniqueness => true
end
