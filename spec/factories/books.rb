FactoryGirl.define do
  factory :book do
    title {Faker::Commerce.product_name}
    description {Faker::Lorem.paragraph}
    price {Faker::Commerce.price}
    in_stock {Faker::Number.between(1, 200) }
    category
    author
  end
end