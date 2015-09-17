class AddStreetToAdress < ActiveRecord::Migration
  def change
    add_column :adresses, :street, :string
  end
end
