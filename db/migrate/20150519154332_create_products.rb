class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :url
      t.string :code

      t.timestamps null: false
    end

    add_index :products, :code, unique: true
  end
end
