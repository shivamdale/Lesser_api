FactoryBot.define do
  factory :email_account, class: 'AccountBlock::EmailAccount' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    full_phone_number { Faker::PhoneNumber.phone_number }
    activated { true }
  end
end