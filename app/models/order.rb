class Order < ActiveRecord::Base
  include AASM

 aasm do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :cancelled

    event :pay do
      transitions :from => :in_progress, :to => :in_queue
    end

    event :processed do
      transitions :from => :in_queue, :to => :in_delivery
    end

    event :delivered do
      transitions :from => :in_delivery
    end, :to => :delivered
    end
    event :cancel do
      transitions :from => [:in_queue, :in_delivery], :to => :canceled
    end
  end


  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  has_one :billing_adress, class_name: "Adress"
  has_one :shipping_adress, class_name: "Adress"
  validates :total_price, :state, :completed_date, presence:true
	def total_price

	end

	def add_book (book)
    self<<BookItem.new(book)
	end
end
