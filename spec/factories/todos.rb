FactoryBot.define do
  factory :todo do
    name { Faker::Lorem.words(3) }
    description { Faker::HowIMetYourMother.quote }
    status { Faker::Lorem.word }
    due_at { Faker::Date.forward(5) }
  end
end