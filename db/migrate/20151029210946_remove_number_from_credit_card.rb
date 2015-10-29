class RemoveNumberFromCreditCard < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :number, :integer
  end
end
