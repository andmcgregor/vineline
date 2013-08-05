class CreateVines < ActiveRecord::Migration
  def change
    create_table :vines do |t|
      t.string :post_id
      t.string :url
      t.string :description
      t.datetime :filmed
      t.string :location

      t.timestamps
    end

    add_column :users, :description, :string
  end
end
