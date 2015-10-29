FactoryGirl.define do

  factory :credit_card do
   number {Faker::Business.credit_card_number.remove('-')}
   cvv { Faker::Number.number(3) }
   expiration_month "2020"
   expiration_year "11"
   firstname  {Faker::Name.first_name}
   lastname  {Faker::Name.last_name}
   user
  end
end


