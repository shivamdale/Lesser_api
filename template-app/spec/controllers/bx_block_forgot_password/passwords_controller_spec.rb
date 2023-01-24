require 'spec_helper'
require 'rails_helper'

RSpec.describe  BxBlockForgotPassword::PasswordsController, type: :controller do
  include ApiHelper

  before(:all) do
    @sms_otp = FactoryBot.create(:sms_otp)
    @sms_account  = FactoryBot.create(:sms_account)
    @new_password =  Faker::Internet.password(max_length: 8, mix_case: true, special_characters: false)+'@'
  end

  it 'set new password for sms account' do
    @sms_otp.update(activated: 'true')
    @sms_otp.reload
    token = BuilderJsonWebToken.encode(@sms_otp.id, 1.day.from_now, type:@sms_otp.class, account_id: @sms_account.id)
    authenticated_header(request, @sms_otp)
    post :create, params: { data: { otp_code: @sms_otp.pin,
                                    new_password: @new_password,
                                    password_confirmation: @new_password,
                                    token: token}}
    res = JSON.parse(response.body)
    puts "#{response.body}"
    expect(response.code).to eq('201')
  	expect(res["data"]["id"]).to eq(@sms_account.id.to_s)
    expect(res["data"]["attributes"]["type"]).to eq("SmsAccount")
  end

  it 'should return error of sms account for invalid otp' do
    @sms_otp.update(activated: 'false')
    @sms_otp.reload
    authenticated_header(request, @sms_otp)
    token = BuilderJsonWebToken.encode(@sms_otp.id, 1.day.from_now, type:@sms_otp.class, account_id: @sms_account.id)
    post :create, params: { data:{new_password: @new_password,
                                  password_confirmation: @new_password,
                                  otp_code: 88838,
                                  token: token}}
    res = JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["otp"]).to eq("OTP code not validated")

    @sms_otp.update(activated: 'true')
    post :create, params: { data:{new_password: Faker::Internet.password,
                                  password_confirmation: Faker::Internet.password,
                                  otp_code: @sms_otp.pin,
                                  token: token}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["password"]).to eq("Password is invalid")
  end
end