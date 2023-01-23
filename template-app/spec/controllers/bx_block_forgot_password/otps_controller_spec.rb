require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockForgotPassword::OtpsController, type: :controller do
  before(:all) do
    @email_account = FactoryBot.create(:email_account)
  end

  it 'send forgot password otp for email account' do
    post :create, params: { data:{ attributes: {
		                        email: @email_account.email }}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('201')
  	expect(res["data"]["id"]).not_to be_nil
    expect(res["meta"]["otp"]).not_to be_nil
  end

  it 'should return error for invalid email' do
    post :create, params: { data:{ attributes: {
                            email: Faker::Internet.email }}}
    res =JSON.parse(response.body)
    expect(response.code).to eq('404')
    expect(res["errors"][0]["otp"]).to eq("Account not found")
  end
end