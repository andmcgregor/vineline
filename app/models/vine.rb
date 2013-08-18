class Vine < ActiveRecord::Base
  belongs_to :user

  validates :url, :video_url, :thumbnail, :filmed, :user_id, presence: true
  validates :video_url, uniqueness: true
end
