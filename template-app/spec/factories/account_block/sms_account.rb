FactoryBot.define do
  factory :sms_account, class: 'AccountBlock::SmsAccount' do
	email { Faker::Internet.email }
    password { Faker::Internet.password(max_length: 8, mix_case: true, special_characters: false)+'@' }
    full_phone_number { Faker::Base.numerify('+91##########') }
    activated { true }
  end
end