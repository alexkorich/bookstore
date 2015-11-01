require "rails_helper"

RSpec.describe UserMailer, type: :mailer do


  let!(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order, :normal) }
  subject(:order_item) { order.order_items.first }

  describe 'received' do
    let(:mail) { UserMailer.delivery(user, order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Bookstore Order Confirmation')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@bookstore.pp.ua'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content order_item.book.title
      expect(mail.body.encoded).to have_content order_item.book.price
    end
  end

  describe 'registered' do
    let(:mail) { UserMailer.registered(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Welcome to My Awesome Site")
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@@'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content order_item.book.title
      expect(mail.body.encoded).to have_content order_item.book.price
    end
  end


  describe 'delivered' do
    let(:mail) { UserMailer.delivery(user, order) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Bookstore Order Shipped')
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to have_content order_item.book.title
      expect(mail.body.encoded).to have_content order_item.book.price
    end
  end




end
