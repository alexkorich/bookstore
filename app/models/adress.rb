class Adress < ActiveRecord::Base
  belongs_to :order
  validates  :address, :zipcode, :city, :phone, :country, presence:true
end
