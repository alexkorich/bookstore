class AddMultiplierToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :multiplier, :float
  end
end
