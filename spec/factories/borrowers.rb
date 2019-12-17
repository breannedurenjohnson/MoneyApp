FactoryBot.define do
  factory :borrower do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    password { "" }
    need_money_for { "MyString" }
    description { "MyString" }
    amount_needed { 1 }
    amount_raised { 1 }
  end
end
