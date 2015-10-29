require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do

  describe "abilities of loggined user" do

    subject { ability }
    let(:user){ FactoryGirl.create(:user) } 
    let(:user2){ FactoryGirl.create(:user) }
    let(:ability){ Ability.new(user) }
   
    context 'for orders' do 
      let(:order){ FactoryGirl.create(:order, user:user) }
      let(:other_order){ FactoryGirl.create(:order) }

      it { expect(subject).to be_able_to(:create, order) }
      it { expect(subject).to be_able_to(:read, order) }
      it { expect(subject).to be_able_to(:update, order) }
      it { expect(subject).to be_able_to(:destroy, order) }

      it { expect(subject).not_to be_able_to(:read, other_order) }
      it { expect(subject).not_to be_able_to(:update, other_order) }
      it { expect(subject).not_to be_able_to(:destroy, other_order) }
    end

    context 'for credit cards' do 
      let(:credit_card){ FactoryGirl.create(:credit_card , user:user) }
      let(:others_credit_card){ FactoryGirl.create(:credit_card) }

      it { expect(subject).to be_able_to(:create, credit_card) }
      it { expect(subject).to be_able_to(:read, credit_card) }
      it { expect(subject).to be_able_to(:update, credit_card) }
      it { expect(subject).to be_able_to(:destroy, credit_card) }

      it { expect(subject).not_to be_able_to(:read, others_credit_card) }
      it { expect(subject).not_to be_able_to(:update, others_credit_card) }
      it { expect(subject).not_to be_able_to(:destroy, others_credit_card) }
    end

    context 'for order items' do 
      let(:order){ FactoryGirl.create(:order, user:user) }
      let(:order_item){ FactoryGirl.create(:order_item , order:order) }
      let(:others_order_item){ FactoryGirl.create(:order_item) }

      it { expect(subject).to be_able_to(:create, order_item) }
      it { expect(subject).to be_able_to(:read, order_item) }
      it { expect(subject).to be_able_to(:update, order_item) }
      it { expect(subject).to be_able_to(:destroy, order_item) }

      it { expect(subject).not_to be_able_to(:read, others_order_item) }
      it { expect(subject).not_to be_able_to(:update, others_order_item) }
      it { expect(subject).not_to be_able_to(:destroy, others_order_item) }
    end

    context 'for ratings' do 
      let(:rating){ FactoryGirl.create(:rating, user:user) }
      let(:others_rating){ FactoryGirl.create(:rating) }

      it { expect(subject).to be_able_to(:create, rating) }
      it { expect(subject).to be_able_to(:read, rating) }
      it { expect(subject).to be_able_to(:update, rating) }
      it { expect(subject).to be_able_to(:destroy, rating) }
      it { expect(subject).to be_able_to(:read, others_rating) }

      it { expect(subject).not_to be_able_to(:update, others_rating) }
      it { expect(subject).not_to be_able_to(:destroy, others_rating) }
    end

     context 'for wishlists' do 
      let(:wish_list){ FactoryGirl.create(:wish_list, user:user) }
      let(:others_wish_list){ FactoryGirl.create(:wish_list) }

      it { expect(subject).to be_able_to(:create, wish_list) }
      it { expect(subject).to be_able_to(:read, wish_list) }
      it { expect(subject).to be_able_to(:update, wish_list) }
      it { expect(subject).to be_able_to(:destroy, wish_list) }

      it { expect(subject).not_to be_able_to(:read, others_wish_list) }
      it { expect(subject).not_to be_able_to(:update, others_wish_list) }
      it { expect(subject).not_to be_able_to(:destroy, others_wish_list) }
    end

    context 'for authors' do 
      let(:author){ FactoryGirl.create(:author) }

      it { expect(subject).to be_able_to(:read, author) }

      it { expect(subject).not_to be_able_to(:create, author) }
      it { expect(subject).not_to be_able_to(:update, author) }
      it { expect(subject).not_to be_able_to(:destroy, author) }
    end

    context 'for books' do 
      let(:book){ FactoryGirl.create(:book) }

      it { expect(subject).to be_able_to(:read, book) }

      it { expect(subject).not_to be_able_to(:create, book) }
      it { expect(subject).not_to be_able_to(:update, book) }
      it { expect(subject).not_to be_able_to(:destroy, book) }
    end
    
    context 'for categories' do 
      let(:category){ FactoryGirl.create(:category) }

      it { expect(subject).to be_able_to(:read, category) }

      it { expect(subject).not_to be_able_to(:create, category) }
      it { expect(subject).not_to be_able_to(:update, category) }
      it { expect(subject).not_to be_able_to(:destroy, category) }
    end

    context 'for checkout' do 
      it { expect(subject).to be_able_to(:read, :order_checkout) }
      it { expect(subject).to be_able_to(:update, :order_checkout) }
    end

    context 'for home' do 
      it { expect(subject).to be_able_to(:add_to_cart, :home) }
      it { expect(subject).to be_able_to(:bestsellers, :home) }
      it { expect(subject).to be_able_to(:index, :home) }
    end
  end

  describe "abilities of admin" do
    subject { ability }
    let(:admin){ FactoryGirl.create(:user, :admin)}
    let(:ability){ Ability.new(admin) }

     context "accessing admin console" do
       it { expect(subject).to be_able_to(:access, :rails_admin) }
       it { expect(subject).to be_able_to(:dashboard, :lil) }
     end 

    context 'for credit cards' do 
      let(:credit_card){ FactoryGirl.create(:credit_card) }
    
      it { expect(subject).to be_able_to(:create, credit_card) }
      it { expect(subject).to be_able_to(:read, credit_card) }
      it { expect(subject).to be_able_to(:update, credit_card) }
      it { expect(subject).to be_able_to(:destroy, credit_card) }
    end

    context 'for order items' do 
      let(:order_item){ FactoryGirl.create(:order_item) }

      it { expect(subject).to be_able_to(:create, order_item) }
      it { expect(subject).to be_able_to(:read, order_item) }
      it { expect(subject).to be_able_to(:update, order_item) }
      it { expect(subject).to be_able_to(:destroy, order_item) }
    end

    context 'for ratings' do 
      let(:rating){ FactoryGirl.create(:rating) }

      it { expect(subject).to be_able_to(:create, rating) }
      it { expect(subject).to be_able_to(:read, rating) }
      it { expect(subject).to be_able_to(:update, rating) }
      it { expect(subject).to be_able_to(:destroy, rating) }
    end

     context 'for wishlists' do 
      let(:wish_list){ FactoryGirl.create(:wish_list) }

      it { expect(subject).to be_able_to(:create, wish_list) }
      it { expect(subject).to be_able_to(:read, wish_list) }
      it { expect(subject).to be_able_to(:update, wish_list) }
      it { expect(subject).to be_able_to(:destroy, wish_list) }
    end

    context 'for authors' do 
      let(:author){ FactoryGirl.create(:author) }

      it { expect(subject).to be_able_to(:create, author) }
      it { expect(subject).to be_able_to(:read, author) }
      it { expect(subject).to be_able_to(:update, author) }
      it { expect(subject).to be_able_to(:destroy, author) }
    end

    context 'for books' do 
      let(:book){ FactoryGirl.create(:book) }

      it { expect(subject).to be_able_to(:create, book) }
      it { expect(subject).to be_able_to(:read, book) }
      it { expect(subject).to be_able_to(:update, book) }
      it { expect(subject).to be_able_to(:destroy, book) }
    end
    
    context 'for categories' do 
      let(:category){ FactoryGirl.create(:category) }

      it { expect(subject).to be_able_to(:create, category) }
      it { expect(subject).to be_able_to(:read, category) }
      it { expect(subject).to be_able_to(:update, category) }
      it { expect(subject).to be_able_to(:destroy, category) }
    end

    context 'for checkout' do 
      it { expect(subject).to be_able_to(:read, :order_checkout) }
      it { expect(subject).to be_able_to(:update, :order_checkout) }
    end

    context 'for home' do 
      it { expect(subject).to be_able_to(:add_to_cart, :home) }
      it { expect(subject).to be_able_to(:bestsellers, :home) }
      it { expect(subject).to be_able_to(:index, :home) }
    end

   end
end
