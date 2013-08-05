class AddThumbnailToVines < ActiveRecord::Migration
  def change
    add_column :vines, :thumbnail, :string
  end
end
