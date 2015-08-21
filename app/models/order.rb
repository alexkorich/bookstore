class Order < ActiveRecord::Base
  include AASM

 aasm column: "state" do
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
      transitions :from => :in_delivery, :to => :delivered
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
    a=0
    self.order_items.each do |item|
      
     a+=item.price*item.quantity
    end
    a
	end

	def add_book(book)
    i=self.order_items.find_by(book: book)
  if i 
    i.quantity+=1
    
      else
    i=self.order_items.build.OrderItem.new(price:book.price, quantity:1, book:book)
  end
  i.save
 	end
end
