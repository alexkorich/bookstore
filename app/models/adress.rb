class Adress < ActiveRecord::Base
  belongs_to :order
  belongs_to :country
  
  validates  :zipcode, :city, :phone, :firstname, :lastname, :adress,  presence:true
end
