class AddUserIdToVines < ActiveRecord::Migration
  def change
    add_column :vines, :user_id, :integer
  end
end
