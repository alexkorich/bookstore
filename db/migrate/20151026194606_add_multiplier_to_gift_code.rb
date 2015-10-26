class AddMultiplierToGiftCode < ActiveRecord::Migration
  def change
    add_column :gift_codes, :multiplier, :float
  end
end
