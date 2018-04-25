FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    name { email.split(/@/)[0] }
    confirmed_at { 2.years.ago }
  end
end
