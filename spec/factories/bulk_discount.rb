FactoryBot.define do
  factory :bulk_discount do
    name { Faker::Name.name }
    percentage { "20.00" }
    threshold { 10 }
    merchant
  end
end
