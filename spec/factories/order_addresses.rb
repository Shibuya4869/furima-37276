FactoryBot.define do
  factory :order_address do
    token         { "tok_abcdefghijk00000000000000000"}
    post_code     { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Address.secondary_address }
    phone         { Faker::Number.number(digits: 11) }
  end
end
