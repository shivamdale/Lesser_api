FactoryBot.define do
  factory :email_account, class: 'AccountBlock::EmailAccount' do
    email { Faker::Internet.email }
    password { Faker::Internet.password(max_length: 8, mix_case: true, special_characters: false)+'@' }
    full_phone_number { Faker::Base.numerify('+91##########') }
    activated { true }
  end
end