class AddAasmStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string, :default => 'in_progress'
  end
  
end
