class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :number
      t.integer :cvv
      t.string :expiration_month
      t.string :expiration_year
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end
  end
end
