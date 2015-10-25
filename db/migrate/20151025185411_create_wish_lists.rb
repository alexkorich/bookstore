class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.integer :user_id
      t.timestamps null: false
    end
    create_table :books_wish_lists, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :wish_list, index: true
    end
  end
end
