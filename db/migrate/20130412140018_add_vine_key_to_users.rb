class AddVineKeyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :full_name, :string
  	add_column :users, :username, :string
  	add_column :users, :avatar, :string
  	add_column :users, :provider, :string
  	add_column :users, :uid, :string
  end
end
