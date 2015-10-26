require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it {should validate_presence_of(:number)}
  it {should validate_uniqueness_of(:number)}
  it {should validate_presence_of(:cvv)}
  it {should validate_presence_of(:expiration_month)}
  it {should validate_presence_of(:expiration_year)}
  it {should validate_presence_of(:firstname)}
  it {should validate_presence_of(:lastname)}
  it {should validate_numericality_of(:number).only_integer}
  it {should validate_numericality_of(:cvv).only_integer}
  it {should allow_value(12).for(:expiration_month)}
  it {should allow_value(01).for(:expiration_year)}
  it {should_not allow_value("dd").for(:expiration_month).with_message("Digits only are allowed")}
  it {should_not allow_value("t6").for(:expiration_year).with_message("Digits only are allowed")}

  it {should belong_to(:user)}
  it {should have_many(:orders)}
end
