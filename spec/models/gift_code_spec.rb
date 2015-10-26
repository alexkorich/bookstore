require 'rails_helper'

RSpec.describe GiftCode, type: :model do

  it {should validate_presence_of(:code)}
  it {should validate_uniqueness_of(:code)}
  it {should validate_presence_of(:multiplier)}
  it {should validate_numericality_of(:multiplier)}
  it {should validate_inclusion_of(:multiplier).in_range(0.6..0.98)}

end
