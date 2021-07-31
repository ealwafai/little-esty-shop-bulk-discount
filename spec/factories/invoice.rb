FactoryBot.define do
  factory :invoice do
    customer
    status { Faker::Number.between(from: 0, to: 2) }
  end
end
