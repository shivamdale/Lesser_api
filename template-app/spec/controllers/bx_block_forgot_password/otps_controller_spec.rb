require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockForgotPassword::OtpsController, type: :controller do
  before(:all) do
    @sms_account = FactoryBot.create(:sms_account)
  end

  it 'send forgot password otp for sms account' do
    post :create, params: { data:{ attributes: {
		                        full_phone_number: @sms_account.full_phone_number }}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('201')
  	expect(res["data"]["id"]).not_to be_nil
    expect(res["meta"]["otp"]).not_to be_nil
  end

  it 'should return error for invalid email' do
    post :create, params: { data:{ attributes: {
                            full_phone_number: Faker::Base.numerify('+91##########') }}}
    res =JSON.parse(response.body)
    expect(response.code).to eq('404')
    expect(res["errors"][0]["otp"]).to eq("Account not found")
  end
end