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

    event :process do
      transitions :from => :in_queue, :to => :in_delivery
    end

    event :deliver do
      transitions :from => :in_delivery, :to => :delivered
    end
    event :cancel do
      transitions :from => [:in_queue, :in_delivery], :to => :cancelled
    end
  end


  belongs_to :customer
  belongs_to :credit_card
  belongs_to :delivery
  has_many :order_items
  has_one :billing_adress, class_name: "Adress"
  has_one :shipping_adress, class_name: "Adress"
  validates :total_price, :state, presence:true
	def total_price
    a=0
    self.order_items.each do |item|
      
     a+=item.price*item.quantity
    end
    a
	end

	def add_book(book, quantity)
    i=self.order_items.find_by(book: book)
  if i 
    i.quantity+=quantity
    
      else
    i=self.order_items.build(price:book.price, quantity:quantity, book:book)
  end
  i.save
 	end


  rails_admin do
    list do
      field :id
      field :state, :state
    end
    edit do
      field :state, :state
    end

     state({
    events: {pay: 'btn-success', process: 'btn-success', deliver: 'btn-success', cancel:'btn-danger'},
    states: {in_queue: 'label-important', in_delivery: 'label-warning', delivered: 'label-success', cancelled:'label-danger'}
  })

  end
end
