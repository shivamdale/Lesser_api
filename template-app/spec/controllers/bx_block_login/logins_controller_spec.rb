require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockLogin::LoginsController, type: :controller do
    include ApiHelper

	before(:all) do
  	    @sms_account = FactoryBot.create(:sms_account)
    end

    it 'login by email' do
        post :create, params: {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "email": @sms_account.email,
                    "password": @sms_account.password           
                },
                "device_id": Faker::Name.name
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(res["meta"]["token"]).not_to be_nil
    end

    it 'login by mobile number' do
        post :create, params: {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "full_phone_number": @sms_account.full_phone_number,
                    "password": @sms_account.password           
                },
                "device_id": Faker::Name.name
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(res["meta"]["token"]).not_to be_nil
    end

    it 'login by invalide account password' do
        post :create, params: {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "full_phone_number": @sms_account.full_phone_number,
                    "password": Faker::Name.name
                },
                "device_id": Faker::Name.name
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('401')
        expect(res["errors"][0]["failed_login"]).to eq("Login Failed")
    end

    it 'login by invalide account' do
        post :create, params: {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": Faker::Name.name
                },
                "device_id": Faker::Name.name
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][0]["failed_login"]).to eq("Account not found, or not activated")
    end

    it 'login by invalide account' do
        post :create, params: {
            "data": {
                "type": "sm_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": Faker::Name.name
                },
                "device_id": Faker::Name.name
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][0]["account"]).to eq("Invalid Account Type")
    end
end