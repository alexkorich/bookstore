class Adress < ActiveRecord::Base
  belongs_to :order
  validates  :zipcode, :city, :phone, :country, presence:true
end
