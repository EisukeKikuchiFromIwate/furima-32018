FactoryBot.define do
  factory :user do
    nickname              { 'tanaka' }
    email                 { 'tanaka@tanaka' }
    password              { '000aaa' }
    password_confirmation { password }
    last_name             { '田中' }
    first_name            { '太郎' }
    last_name_kana        { 'タナカ' }
    first_name_kana       { 'タロウ' }
    birth_day             { '2000-01-01' }
  end
end
