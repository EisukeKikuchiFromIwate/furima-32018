FactoryBot.define do
  factory :user_order do
    token         { "tok_abcdefghijk00000000000000000" }
    postal_code   { '000-0000' }
    prefecture_id { 3 }
    city          { '盛岡市' }
    addresses     { '開運橋' }
    building      { 'メゾン盛岡' }
    phone_number  { '08012341234' }
    user_id       { 1 }
    item_id       { 1 }
  end
end
