require 'rails_helper'

RSpec.describe Adress, type: :model do

    it {should validate_presence_of(:adress)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:country)}
    it {should validate_presence_of(:firstname)}
    it {should validate_presence_of(:lastname)}
    it {should validate_numericality_of(:zipcode)}

    it {should belong_to(:country)}
end
