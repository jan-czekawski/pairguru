FactoryBot.define do
  factory :comment do
    content { Faker::Friends.quote }
    user { User.all.sample }
    movie { Movie.all.sample }
  end
end
