class GiftCode < ActiveRecord::Base
  validates :code, :multiplier, presence:true
  validates :code, uniqueness:true
  validates :multiplier, numericality: true
  validates :multiplier, :inclusion => {:in => 0.6..0.98}
end
