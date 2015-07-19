class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book
  validates :rating, presence: true
  validates :rating, :inclusion => {:in => [1,2,3,4,5,6,7,8,9,10]}
end
