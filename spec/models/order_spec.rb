require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { order }
  let(:order)           { FactoryGirl.create :order }
  let(:book)            { FactoryGirl.create :book}
  let(:user)            { FactoryGirl.create(:user) } 
  let(:credit_card)     { FactoryGirl.build(:credit_card , user:user) }
  let(:order_item)      { FactoryGirl.build(:order_item) }
  let(:delivery)        { FactoryGirl.build(:delivery)}
  let(:billing_adress)  { FactoryGirl.build(:billing_adress)}
  let(:shipping_adress) { FactoryGirl.build(:shipping_adress)}
  let(:gift_code)       { FactoryGirl.create(:gift_code)}

  describe "validation" do
    it {should validate_presence_of(:state)}
    it {should belong_to(:user)}
    it {should belong_to(:credit_card)}
    it {should belong_to(:delivery)}
    it {should belong_to(:billing_adress)}
    it {should have_many(:order_items)}
    context 'active_or_adress' do
      before { subject.stub(:active_or_adress?) { true } }
      it {should validate_presence_of(:billing_adress)}
      it {should validate_presence_of(:shipping_adress)}
    end
    context 'active_or_delivery' do
      before { subject.stub(:active_or_delivery?) { true } }
      it {should validate_presence_of(:delivery)}
    end
   context 'active_or_payment' do
      before { subject.stub(:active_or_payment?) { true } }
      it {should validate_presence_of(:credit_card)}
    end
    context 'active' do
      before { subject.stub(:active?) { true } }
      it {should validate_presence_of(:completed_date)}
    end
  end
  describe 'methods' do
     describe '#active?' do
       it "returns true if status==active" do
         order.status='active'
         expect(order.active?).to eq(true)
       end
       it "returns false if status!=active" do
         order.status='kk'
         expect(order.active?).to eq(false)
        end
     end 
    describe '#active_or_adress?' do
       it "returns true if status==active" do
         order.status='active'
         expect(order.active_or_adress?).to eq(true)
       end
        it "returns true if status==adress" do
         order.status='adress'
         expect(order.active_or_adress?).to eq(true)
       end
       it "returns false if status!=active" do
         order.status='kk'
         expect(order.active_or_adress?).to eq(false)
        end
     end   
     describe '#active_or_delivery?' do
        it "returns true if status==active" do
         order.status='active'
         expect(order.active_or_delivery?).to eq(true)
       end
        it "returns true if status==delivery" do
         order.status='delivery'
         expect(order.active_or_delivery?).to eq(true)
       end
       it "returns false if status!=active" do
         order.status='kk'
         expect(order.active_or_delivery?).to eq(false)
        end
     end   
     describe '#active_or_payment?' do
        it "returns true if status==active" do
         order.status='active'
         expect(order.active_or_payment?).to eq(true)
       end
        it "returns true if status==payment" do
         order.status='payment'
         expect(order.active_or_payment?).to eq(true)
       end
       it "returns false if status!=active" do
         order.status='kk'
         expect(order.active_or_payment?).to eq(false)
        end
     end   
     describe '#total_price' do
        it "returns 0 if nothing in" do
         order.delivery=nil
         expect(order.total_price).to eq(0)
       end
       it "returns deliv price if nothing in && del" do
         order.delivery=delivery
         expect(order.total_price).to eq(delivery.price)
       end
        it "returns item price if item" do
         order.order_items<<order_item
         order.delivery=delivery
         expect(order.total_price).to eq(delivery.price+order_item.price*order_item.quantity)
       end
        it "returns discounted if enter code" do
          gift_code
          order.gift_code(gift_code.code)
         order.order_items<<order_item
         order.delivery=delivery
         expect(order.total_price).to be_within(0.000000001).of(delivery.price+(order_item.price*order_item.quantity)*gift_code.multiplier )
       end
     end 
    describe '#gift_code' do
      it "do nothing if state!=in_progress" do
        order.state="in_queue"
        expect(order.gift_code(gift_code.code)).to eq(nil)
        expect{order.gift_code(gift_code.code)}.not_to change {order.multiplier}.from(nil)
     end   
       it "change nothing if mult is set" do
         order.multiplier=0.8
         expect(order.gift_code(gift_code.code)).to eq("Sorry, you've used one! :(")
         expect{order.gift_code(gift_code.code)}.not_to change {order.multiplier}.from(0.8)
        end   
       it "ret sorry if code wrong" do
         expect(order.gift_code('22222')).to eq("Sorry, code is wrong! :(")
         expect{order.gift_code('22222')}.not_to change {order.multiplier}.from(nil)
        end 
     it "sets discount if code ok" do
         expect(order.gift_code(gift_code.code)).to eq(true)
         expect(order.multiplier).to be_within(0.000000001).of(gift_code.multiplier)
      end 
    end
    describe '#add_book' do
       it 'adds book to order if not present' do
         book
         expect(order.order_items.exists?).to eq(false)
         order.add_book(book, 1)
         expect(order.order_items.first.book).to eq(book)
         expect(order.total_price).to eq(book.price)
         expect(order.order_items.count).to eq(1)
       end
       #?????????????????????????
       xit '++ quantity in order_items if present' do
         book
         order
         expect(order.order_items.exists?).to eq(false)
         order.add_book(book, 1)
         # order.save
         puts order.total_price
         expect(order.order_items.first.quantity).to eq(1)
         order.add_book(book, 1)
         puts order.order_items.first.quantity
         puts order.total_price
         puts book.price
         # expect(order.total_price).to eq(book.price*2)
         expect(order.order_items.first.quantity).to eq(2)
         expect(order.order_items.count).to eq(1)
       end
     end 
     describe '#notify_delivery' do
      it "sends smth" do
      expect {subject.notify_delivery}.to change {ActionMailer::Base.deliveries.count }.by(2)
    end

     end 
    describe '#notify_pay' do
      it "send smth" do
      expect {subject.notify_pay}.to change {ActionMailer::Base.deliveries.count }.by(2)
    end
    end 
  end


  describe 'aasm' do
    describe 'states' do
      describe ':in_progress' do
        it 'should be an initial state' do
          expect(order.state).to eq("in_progress")
        end
        it 'should change to :idling on :ignite' do
          order.pay!
          expect(order.state).to eq("in_queue")
        end
        ['process!', 'deliver!', 'cancel!'].each do |action|
          it "should raise an error for #{action}" do
            lambda {order.send(action)}.should raise_error
          end
        end
      end
     describe ':in_queue' do
       it 'should change to in_delivery on :process' do
        order.pay!
        order.process!
        expect(order.state).to eq("in_delivery")
       end
       it 'should change to cancelled on :cancel' do
        order.pay!
        order.cancel!
        expect(order.state).to eq("cancelled")
       end
       ['notify_pay!', 'notify_delivery!'].each do |action|
        it "should raise an error for #{action}" do
          order.pay!
          lambda {order.send(action)}.should raise_error
        end
      end
    end
  end
  end
end
