FactoryGirl.define do
  factory :gift_code do
    code {Faker::Internet.password}
    multiplier{Faker::Number.between(0.6, 0.98)}
  end
end