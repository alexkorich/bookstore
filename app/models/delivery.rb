class Delivery < ActiveRecord::Base
  validates :name, presence:true
  validates :name, uniqueness:true
  validates :price, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0}
end
