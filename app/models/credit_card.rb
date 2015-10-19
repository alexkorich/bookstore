class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :expiration_month, :expiration_year, :firstname, :lastname, presence:true
  # validates :number, :cvv, numericality:{only_integer: true}
  validates :number, uniqueness:true
  validates :expiration_month, :expiration_year, format: { with: /^[0-9]+#/,  :multiline => true, message: "Digits only are allowed" }


  has_many :orders
end
