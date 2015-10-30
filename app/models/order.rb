class Order < ActiveRecord::Base
  include AASM
  validates :total_price, :state, presence:true
  validates :billing_adress, presence: true,   if: :active_or_adress?
  validates :shipping_adress, presence: true,  if: :active_or_adress?
  validates :delivery, presence: true,         if: :active_or_delivery?
  validates :credit_card, presence: true,      if: :active_or_payment?
  validates :completed_date, presence: true,   if: :active?
  validates_associated :billing_adress, :shipping_adress, :credit_card, :delivery

  belongs_to :user
  belongs_to :credit_card
  belongs_to :delivery
  has_many :order_items
  belongs_to :billing_adress, class_name: "Adress"
  belongs_to :shipping_adress, class_name: "Adress"

  aasm column: "state" do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :cancelled

    event :pay,  :after => :notify_pay  do
      transitions :from => :in_progress, :to => :in_queue
    end

    event :process, :after => :notify_delivery do
      transitions :from => :in_queue, :to => :in_delivery
    end

    event :deliver do
      transitions :from => :in_delivery, :to => :delivered
    end
    event :cancel do
      transitions :from => [:in_queue, :in_delivery], :to => :cancelled
    end
  end
    
   def active?
    status == 'active'
  end

  def active_or_adress?
    (status || '').include?('adress') || active?
  end

  def active_or_delivery?
    (status || '').include?('delivery') || active?
  end

  def active_or_payment?
    (status || '').include?('payment') || active?
  end




	def total_price
    a=0
    if self.order_items
      self.order_items.each do |item|
        
       a+=item.price*item.quantity
    end
    end
    if self.multiplier
      a=a*self.multiplier
    end
    if self.delivery
      a=a+self.delivery.price.to_f
    end
    self.total_price=a
    a
	end

  def gift_code(code)
    if self.state =="in_progress"
      if !self.multiplier
      gift=GiftCode.find_by(code: code)
      if gift
        self.multiplier=gift.multiplier
        self.save!
        return true
      else
        return "Sorry, code is wrong! :("
      end
    else 
      return "Sorry, you've used one! :("
    end
    else
      return
    end
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

  def notify_delivery
    
    UserMailer.delivery(User.find(self.user_id), self).deliver_now
  end

  def notify_pay
    
     UserMailer.pay(User.find(self.user_id), self).deliver_now
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
      events: {process: 'btn-success', deliver: 'btn-success', cancel:'btn-danger'},
      states: {in_queue: 'label-important', in_delivery: 'label-warning', delivered: 'label-success', cancelled:'label-danger'},
      disable: [:pay]
    })
  end


end
