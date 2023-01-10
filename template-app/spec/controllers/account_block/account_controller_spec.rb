require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do
    let(:sign_up_params) { 
        {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": "a@yopmail.com",
                    "password": "123123123",
                    "password_confirmation":"123123123",
                    "first_name": "test_one",
                    "last_name": "last_one"
                }
            }
        }
    }

    let(:invalid_password_sign_up_params) { 
        {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": "b@yopmail.com",
                    "password": "123123123",
                    "password_confirmation": "12312312",
                    "first_name": "test_one",
                    "last_name": "last_one"
                }
            }
        }
    }

    let(:invalid_term_and_condition_sign_up_params) {
       {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": "b@yopmail.com",
                    "password": "123123123",
                    "password_confirmation": "123123123",
                    "first_name": "test_one",
                    "last_name": "last_one"
                }
            }
        }
    }

    let(:invalid_age_limit_sign_up_params) {
        {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": "b@yopmail.com",
                    "password": "123123123",
                    "password_confirmation": "12312312",
                    "first_name": "test_one",
                    "last_name": "last_one"
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
