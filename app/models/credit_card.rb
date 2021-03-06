class CreditCard < ActiveRecord::Base
  validates :number, :cvv, :expiration_month, :expiration_year, :firstname, :lastname, presence:true
  validates :number, :cvv, numericality:{only_integer: true}
  validates :number, uniqueness:true
  validates :expiration_month, :expiration_year, format: { with: /^\d+$/,  :multiline => true, message: "Digits only are allowed" }
  belongs_to :user
  has_many :orders
end
