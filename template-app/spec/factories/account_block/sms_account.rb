FactoryBot.define do
  factory :sms_account, class: 'AccountBlock::SmsAccount' do
	full_phone_number { Faker::Base.numerify('+91##########') }
    password { Faker::Internet.password }
    activated { true }
  end
end