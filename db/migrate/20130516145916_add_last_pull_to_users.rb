class AddLastPullToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_pull, :datetime
    add_column :users, :pull_upto, :string
  end
end
