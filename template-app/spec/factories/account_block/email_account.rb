FactoryBot.define do
  factory :email_account, class: 'AccountBlock::EmailAccount' do
    email { Faker::Internet.email }
    password { '12345678' }
    activated { true }
  end
end