FactoryBot.define do
  factory :message do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
