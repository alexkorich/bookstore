class Customer < ActiveRecord::Base
  validates :email, :password, :firstname, :lastname presence: true
  validates :email, uniqueness:true
  has_many :orders
  has_many :ratings
  
end
