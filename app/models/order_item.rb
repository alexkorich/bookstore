class OrderItem < ActiveRecord::Base
 
  validates :price, :quantity, presence:true
  validates :quantity, numericality:{only_integer: true}
  validates :price, numericality: {greater_than_or_equal_to: 0}

  belongs_to :book
  belongs_to :order
end
