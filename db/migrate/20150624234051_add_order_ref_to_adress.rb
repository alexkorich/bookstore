class AddOrderRefToAdress < ActiveRecord::Migration
  def change
    add_reference :adresses, :order, index: true, foreign_key: true
  end
end
