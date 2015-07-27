class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :password, :firstname, :lastname, presence:true
  validates :email, uniqueness:true
  has_many :orders
  has_many :ratings
  
  def create_order

  end
  def current_order

  # status=in_progress
  end
end
