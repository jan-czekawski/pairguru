FactoryBot.define do
  factory :comment do
    content { Faker::Friends.quote }
    user { create(:user) }
    movie { create(:movie) }
  end
end
