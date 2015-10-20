class RemoveOrderIdFromAdress < ActiveRecord::Migration
  def change
    remove_column :adresses, :order_id, :integer
  end
end
