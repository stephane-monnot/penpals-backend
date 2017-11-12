FactoryBot.define do
  sequence :email do |n|
    "monnot.stephane+#{n}@gmail.comperson"
  end

  factory :user do
    name {Faker::Name.name}
    email { generate(:email) }
    password 'foobar'
  end
end
