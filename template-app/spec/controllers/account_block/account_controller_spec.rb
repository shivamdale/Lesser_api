require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do
    before(:all) do
      @password = Faker::Internet.password
    end
    let(:sign_up_params) {
        {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": @password,
                    "password_confirmation": @password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name
                }
            }
        }
    }

    let(:invalid_password_sign_up_params) { 
        {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": @password,
                    "password_confirmation": Faker::Internet.password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name
                }
            }
        }
    }

    it 'create account signup' do
        post :create, params: sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('201')
        expect(res["data"]["type"]).to eq("email_account")
    end

    it 'give error for inavlid password' do 
        post :create, params: invalid_password_sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][0]["password_confirmation"]).to eq("doesn't match Password")
    end
end
