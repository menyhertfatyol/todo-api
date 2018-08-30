FactoryBot.define do
  factory :todo do
    name { Faker::Lorem.words }
    description { Faker::HowIMetYourMother.quote }
    status { ["completed", "incomplete"].sample }
    due_at { Faker::Date.forward(5) }
  end
end