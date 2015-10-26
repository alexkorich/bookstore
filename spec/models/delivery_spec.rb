require 'rails_helper'

RSpec.describe Delivery, type: :model do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:price)}
    it {should validate_numericality_of(:price).is_greater_than(0)}
end
