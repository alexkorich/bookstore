class Country < ActiveRecord::Base
  has_many :adresses
  validates :name, presence:true
  validates :name, uniqueness:true
end
