FactoryBot.define do
  factory :email_account, class: 'AccountBlock::EmailAccount' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    activated { true }
  end
end