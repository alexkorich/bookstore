class CreateAdresses < ActiveRecord::Migration
  def change
    create_table :adresses do |t|
      t.string :adress
      t.integer :zipcode
      t.string :city
      t.string :phone
      t.string :country

      t.timestamps null: false
    end
  end
end
