FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    phone "+79876761642"
  end
end
