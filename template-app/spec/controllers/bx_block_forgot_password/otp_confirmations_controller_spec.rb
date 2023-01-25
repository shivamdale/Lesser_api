require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockForgotPassword::OtpConfirmationsController, type: :controller do
  include ApiHelper

  before(:all) do
    @sms_otp = FactoryBot.create(:sms_otp)
  end

  it 'activate forgot pasword otp for email' do
    token = BuilderJsonWebToken.encode(@sms_otp.id, 1.day.from_now, type:@sms_otp.class)
    post :create, params: { data: { otp_code: @sms_otp.pin,
                                      token: token}}
            
    res =JSON.parse(response.body)
    expect(response.code).to eq('201')
  	expect(res["messages"][0]["otp"]).to eq("OTP validation success")
  end

  it 'should return error of email account for invalid otp' do
    token = BuilderJsonWebToken.encode(@sms_otp.id, 1.day.from_now, type:@sms_otp.class)
    post :create, params: { data:{otp_code: Faker::Number.number,
                                  token: token}}
    res =JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["otp"]).to eq("Invalid OTP code")
  end
end