class CreateVines < ActiveRecord::Migration
  def change
    create_table :vines do |t|
      t.string   :post_id
      t.string   :url
      t.string   :video_url
      t.string   :thumbnail
      t.string   :description
      t.datetime :filmed
      t.string   :location
      t.integer  :user_id

      t.timestamps
    end
  end
end
