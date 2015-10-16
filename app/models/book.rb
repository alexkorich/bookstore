class Book < ActiveRecord::Base
  
  validates :title, :price, :in_stock, presence: true
  validates :price, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :in_stock, numericality: {greater_than_or_equal_to: 0, only_integer: true}


  belongs_to :author
  belongs_to :category
  has_many :ratings, dependent: :destroy

  mount_uploader :cover, BookCoverUploader
end
