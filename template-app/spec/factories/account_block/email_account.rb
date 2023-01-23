FactoryBot.define do
  factory :email_account, class: 'AccountBlock::EmailAccount' do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 12, mix_case: true, special_characters: true) }
    full_phone_number { Faker::Base.numerify('+91##########') }
    activated { true }
  end
end