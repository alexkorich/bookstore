FactoryGirl.define do
  factory :order do
  user

    trait :normal do
        credit_card
  delivery
    end
  end
end