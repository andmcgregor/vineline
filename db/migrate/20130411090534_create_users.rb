class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :full_name
      t.string   :username
      t.string   :avatar
      t.string   :description
      t.string   :location
      t.string   :provider
      t.string   :uid
      t.string   :oauth_token
      t.string   :oauth_secret
      t.datetime :last_pull
      t.string   :pull_upto

      t.timestamps
    end
  end
end
