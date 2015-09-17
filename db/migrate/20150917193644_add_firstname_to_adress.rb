class AddFirstnameToAdress < ActiveRecord::Migration
  def change
    add_column :adresses, :firstname, :string
  end
end
