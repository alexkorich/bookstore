class AddCountryToAdress < ActiveRecord::Migration
  def change
    add_column :adresses, :country_id, :integer
  end
end
