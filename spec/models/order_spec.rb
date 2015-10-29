require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:order) { FactoryGirl.create :order }
    it {should validate_presence_of(:state)}


    it {should belong_to(:user)}
    it {should belong_to(:credit_card)}
    it {should belong_to(:delivery)}
    it {should belong_to(:billing_adress)}

    it {should have_many(:order_items)}

    context 'active_or_adress' do
      it {should validate_presence_of(:billing_adress)}
      it {should validate_presence_of(:shipping_adress)}

    end

    context 'active_or_delivery' do
      
    end
   context 'active_or_payment' do
      
    end
    context 'active' do
      
    end













end
