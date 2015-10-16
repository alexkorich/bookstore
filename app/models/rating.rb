class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :rating, presence: true
  
  validates :rating, numericality:{only_integer: true, in: 1..10}
  validates :user, presence: true
  validates :book, presence: true
end
