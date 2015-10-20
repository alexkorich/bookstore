class Adress < ActiveRecord::Base
  belongs_to :order
  belongs_to :country
  
  validates  :adress, :zipcode, :city, :phone, :firstname, :lastname, presence:true
end
