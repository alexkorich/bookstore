FactoryGirl.define do 
  factory :delivery do
    name {Faker::Commerce.product_name}
   price {Faker::Commerce.price}
  end
end