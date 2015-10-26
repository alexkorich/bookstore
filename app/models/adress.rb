class Adress < ActiveRecord::Base
 

  belongs_to :country
  
  validates  :adress, :zipcode, :city, :phone, :country, :firstname, :lastname, presence:true

   validates :zipcode, numericality: true
end
