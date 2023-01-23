require 'spec_helper'
require 'rails_helper'

RSpec.describe  BxBlockForgotPassword::PasswordsController, type: :controller do
  include ApiHelper

  before(:all) do
    @email_otp = FactoryBot.create(:email_otp)
    @email_account  = FactoryBot.create(:email_account)
    @new_password =  Faker::Internet.password(max_length: 8)+'@'
  end

  it 'set new password for email account' do
    @email_otp.update(activated: 'true')
    @email_otp.reload
    token = BuilderJsonWebToken.encode(@email_otp.id, 1.day.from_now, type:@email_otp.class, account_id: @email_account.id)
    authenticated_header(request, @email_otp)
    post :create, params: { data: { otp_code: @email_otp.pin,
                                    new_password: @new_password,
                                    password_confirmation: @new_password,
                                    token: token}}
    res = JSON.parse(response.body)
    puts "#{response.body}"
    expect(response.code).to eq('201')
  	expect(res["data"]["id"]).to eq(@email_account.id.to_s)
    expect(res["data"]["attributes"]["type"]).to eq("EmailAccount")
  end

  it 'should return error of email account for invalid email' do
    @email_otp.update(activated: 'false')
    @email_otp.reload
    authenticated_header(request, @email_otp)
    token = BuilderJsonWebToken.encode(@email_otp.id, 1.day.from_now, type:@email_otp.class, account_id: @email_account.id)
    post :create, params: { data:{new_password: @new_password,
                                  password_confirmation: @new_password,
                                  otp_code: 88838,
                                  token: token}}

    res = JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["otp"]).to eq("OTP code not validated")

    @email_otp.update(activated: 'true')
    post :create, params: { data:{new_password: Faker::Internet.password,
                                  password_confirmation: Faker::Internet.password,
                                  otp_code: @email_otp.pin,
                                  token: token}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["password"]).to eq("Password is invalid")
  end
end