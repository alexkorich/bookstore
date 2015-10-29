FactoryGirl.define do
  factory :user do
    admin false
    firstname  {Faker::Internet.user_name}
    lastname   {Faker::Internet.user_name}
    email      {Faker::Internet.email}
    password              "password"
    password_confirmation "password"
    avatar { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    trait :with_order do
      order {build(:order, total_price:200)}
    end
    trait :admin do
      admin true
    end


  end
end