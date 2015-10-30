require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { order }
  let(:order) { FactoryGirl.create :order }
  let(:user){ FactoryGirl.create(:user) } 
  let(:credit_card){ FactoryGirl.build(:credit_card , user:user) }
  let(:order_item){ FactoryGirl.build(:order_item) }
  let(:delivery){FactoryGirl.build(:delivery)}
  let(:billing_adress){FactoryGirl.build(:billing_adress)}
  let(:shipping_adress){FactoryGirl.build(:shipping_adress)}
   let(:gift_code){FactoryGirl.create(:gift_code)}

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
       
     end   
    describe '#add_book' do
       
     end 
     describe '#notify_delivery' do
     end 
    describe '#notify_pay' do
    end 
  end


  describe 'aasm' do
    
  end










end
