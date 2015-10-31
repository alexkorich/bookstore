require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { FactoryGirl.create :user }
  let (:order) {FactoryGirl.create :order }
  context "validation" do
    it {should validate_presence_of(:email)}
    it {should have_many(:orders)}
    it {should have_many(:ratings)}
    it {should have_many(:credit_cards)}
  end
  context "instance methods" do


   describe '#current_order' do
     it "creates new order if no present" do
       expect(user.current_order).to be_a Order
       expect(user.current_order.state).to eq("in_progress")
     end
     it "returns current_order" do
       expect(order.user.current_order).to eq(order)
       expect(order.user.current_order.state).to eq("in_progress")
     end
   end
   describe '#create_order' do
     it "adds a new order to existing" do
      orders_count=user.orders.count
      user.create_order
      expect(user.orders.count).to eq(orders_count+1)
     end
  end
   describe '#send_admin_mail' do
    it "adds mail counter" do
      expect {user.send_admin_mail}.to change {ActionMailer::Base.deliveries.count }.by(2)

    end

end
context 'class methods ' do
   describe '.from_omniauth' do
end
 describe '.find_for_oauth' do
end
end
  end

end
