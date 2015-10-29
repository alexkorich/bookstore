FactoryGirl.define do
  
  factory :author do

    firstname  {Faker::Internet.user_name}
    lastname   {Faker::Internet.user_name}
    biography  {Faker::Lorem.paragraph}

     end
end