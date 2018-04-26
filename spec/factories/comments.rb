FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(20, true) }
    user { create(:user) }
    movie { create(:movie) }
  end
end
