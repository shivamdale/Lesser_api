require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do
    before(:all) do
      @password = Faker::Internet.password
      @age_group = FactoryBot.create(:age_group)
      @gender = FactoryBot.create(:gender)
      @city = FactoryBot.create(:city)
      @email = Faker::Internet.email
    end
    let(:sign_up_params) {
        {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "email": @email,
                    "password": @password,
                    "password_confirmation": @password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name,
                    "term_and_conditions": true,
                    "age_group_id": @age_group.id,
                    "gender_id": @gender.id,
                    "city_id": @city.id,
                    "district": Faker::Address.city,
                    "full_phone_number": Faker::PhoneNumber.phone_number
                }
            }
        }
    }

    let(:invalid_password_sign_up_params) { 
        {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": @password,
                    "password_confirmation": Faker::Internet.password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name,
                     "term_and_conditions": true,
                    "age_group_id": @age_group.id,
                    "gender_id": @gender.id,
                    "city_id": @city.id,
                    "district": Faker::Address.city,
                    "full_phone_number": Faker::PhoneNumber.phone_number
                }
            }
        }
    }

    let(:sign_up_params_without_term_and_conditions) {
        {
            "data": {
                "type": "sms_account",
                "attributes": {
                    "email": Faker::Internet.email,
                    "password": @password,
                    "password_confirmation": @password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name,
                    "term_and_conditions": false,
                    "age_group_id": @age_group.id,
                    "gender_id": @gender.id,
                    "city_id": @city.id,
                    "district": Faker::Address.city,
                    "full_phone_number": Faker::PhoneNumber.phone_number
                }
            }
        }
    }

    let(:invalide_account_type_sign_up_params) {
        {
            "data": {
                "type": "smss_account",
                "attributes": {
                    "email": @email,
                    "password": @password,
                    "password_confirmation": @password,
                    "first_name": Faker::Name.first_name,
                    "last_name": Faker::Name.last_name,
                    "term_and_conditions": true,
                    "age_group_id": @age_group.id,
                    "gender_id": @gender.id,
                    "city_id": @city.id,
                    "district": Faker::Address.city,
                    "full_phone_number": Faker::PhoneNumber.phone_number
                }
            }
        }
    }

    it 'create account signup' do
        post :create, params: sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('201')
        expect(res["data"]["type"]).to eq("sms_account")
    end

    it 'give error when create account signup with existing email' do
        post :create, params: sign_up_params, as: :json
        post :create, params: sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][1]["email"]).to eq("has already been taken")
    end

    it 'give error for inavlid password' do 
        post :create, params: invalid_password_sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][0]["password_confirmation"]).to eq("doesn't match Password")
    end

    it 'give error for user does not accept term and conditions' do 
        post :create, params: sign_up_params_without_term_and_conditions, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"]).to eq("please accept the term and condition")
    end

    it 'invalide  account type signup' do
        post :create, params: invalide_account_type_sign_up_params, as: :json
        res =JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(res["errors"][0]["account"]).to eq("Invalid Account Type")
    end
end
