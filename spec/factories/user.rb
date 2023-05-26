FactoryBot.define do
  factory :user do
    username {'John_Doe'}
    email {'john@example.com'}
    password {'password'}
    phone_number {'9090909090'}
    pincode {'044040'}
  end
end
