class AddBillingAdressIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :billing_adress_id, :integer
  end
end
