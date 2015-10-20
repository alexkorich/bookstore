class AddShippingAdressIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_adress_id, :integer
  end
end
