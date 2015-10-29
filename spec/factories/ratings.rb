FactoryGirl.define do
 
  factory :rating do
   text_review {Faker::Lorem.sentence}
   rating {Faker::Number.between(1, 10) }
   user
   book
  end
end