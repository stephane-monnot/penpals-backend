FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email 'monnot.stephane@gmail.com'
    password 'foobar'
  end
end
