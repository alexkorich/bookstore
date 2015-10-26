class RemoveMultiplierFromGiftCode < ActiveRecord::Migration
  def change
    remove_column :gift_codes, :multiplier, :string
  end
end
