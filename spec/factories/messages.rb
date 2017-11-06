FactoryBot.define do
  factory :message do
    title {Faker::Lorem.word}
    content {Faker::Lorem.paragraph}
    created_by {Faker::Number.number(10)}
  end
end
