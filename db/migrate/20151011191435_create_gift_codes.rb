class CreateGiftCodes < ActiveRecord::Migration
  def change
    create_table :gift_codes do |t|
      t.string :code
      t.string :multiplier

      t.timestamps null: false
    end
  end
end
