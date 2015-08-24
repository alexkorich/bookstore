class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders
  has_many :ratings
  
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
   mount_uploader :avatar, AvatarUploader

  def create_order
    self.orders<<Order.new
  end

  def current_order
    @current_order=self.orders.find_or_create_by(state:"in_progress")
    
  end


def self.from_omniauth(auth)
  # split name
  puts auth.info
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.email
    user.password = Devise.friendly_token[0,20]
    user.firstname = auth.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image
  user
  end

end
def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

end
