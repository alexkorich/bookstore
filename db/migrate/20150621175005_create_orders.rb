class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total_price
      t.datetime :completed_date
      t.string :state

      t.timestamps null: false
    end
  end
end
