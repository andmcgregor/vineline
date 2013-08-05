class AddVidUrlToVines < ActiveRecord::Migration
  def change
    add_column :vines, :video_url, :string
  end
end
