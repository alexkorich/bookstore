class AddNumberToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :number, :string
  end
end
