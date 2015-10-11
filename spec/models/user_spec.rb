require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation" do
    it {should validate_presence_of(:email)}
    it {should have_many(:orders)}
    it {should have_many(:ratings)}
  end
end
