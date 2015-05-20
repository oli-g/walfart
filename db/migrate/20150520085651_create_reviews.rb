class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :product, index: true, foreign_key: true
      t.string :code
      t.string :title
      t.text :content
      t.string :user
      t.string :location

      t.timestamps null: false
    end

    add_index :reviews, :code, unique: true
  end
end
