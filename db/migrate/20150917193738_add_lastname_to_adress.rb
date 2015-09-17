class AddLastnameToAdress < ActiveRecord::Migration
  def change
    add_column :adresses, :lastname, :string
  end
end
