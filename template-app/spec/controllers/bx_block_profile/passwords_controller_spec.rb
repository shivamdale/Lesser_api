require 'spec_helper'
require 'rails_helper'

RSpec.describe  BxBlockProfile::PasswordsController, type: :controller do
  include ApiHelper

  before(:all) do
    @email_account  = FactoryBot.create(:email_account)
    @new_password =  Faker::Internet.password(max_length: 8)+'@'
  end

  it 'change password for email account' do
    authenticated_header(request, @email_account)
    put :update, params: { data: { current_password: @email_account.password,
                                    new_password: @new_password,
                                    password_confirmation: @new_password}}
    res = JSON.parse(response.body)
    expect(response.code).to eq('201')
  	expect(res["data"]["id"]).to eq(@email_account.id.to_s)
    expect(res["data"]["attributes"]["type"]).to eq("EmailAccount")
  end

  it 'should return error of email account for invalid password' do
    authenticated_header(request, @email_account)
    put :update, params: { data: { current_password: Faker::Internet.password,
                                    new_password: @new_password,
                                    password_confirmation: @new_password}}

    res = JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["profile"]).to eq("Invalid credentials")

    @email_account.update(activated: 'true')
    put :update, params: { data: { current_password: Faker::Internet.password,
                                    new_password: @new_password,
                                    password_confirmation:  @new_password}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["profile"]).to eq("Invalid credentials")

    put :update, params: { data: { current_password: @email_account.password,
                                    new_password: @new_password,
                                    password_confirmation:  Faker::Internet.password}}

    res =JSON.parse(response.body)
    expect(response.code).to eq('422')
    expect(res["errors"][0]["profile"][0]).to eq("Password confirmation doesn't match Password")
  end
end