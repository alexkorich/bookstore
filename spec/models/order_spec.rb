require 'rails_helper'

RSpec.describe Order, type: :model do
    it {should validate_presence_of(:price)}
    it {should validate_numericality_of(:price).is_greater_than(0)}
    it {should validate_presence_of(:quantity)}
    it {should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:quantity).only_integer}
    it {should belong_to(:order)}
    it {should belong_to(:book)}
end
