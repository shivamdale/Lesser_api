FactoryBot.define do
  factory :sms_otp, class: 'AccountBlock::SmsOtp' do
    pin { '123456' } 
    valid_until { Date.today+1.day}
    full_phone_number { Faker::Base.numerify('+91##########') }
  end 
end
