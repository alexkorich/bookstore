class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  has_one :billing_adress, class_name: "Adress"
  has_one :shipping_adress, class_name: "Adress"
  validates :total_price, :state, :completed_date, presence:true
	def total_price

	end

	def add_book (book)
	end
end
