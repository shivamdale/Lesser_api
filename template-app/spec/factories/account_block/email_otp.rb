FactoryBot.define do
	factory :email_otp, class: 'AccountBlock::EmailOtp' do
    pin { '123456' } 
    valid_until { Date.today+1.day}
    email { Faker::Internet.email }
  end 
end