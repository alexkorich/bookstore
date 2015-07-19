class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :text_review
      t.integer :rating

      t.timestamps null: false
    end
  end
end
