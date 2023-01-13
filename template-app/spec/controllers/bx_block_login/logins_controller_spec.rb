require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockLogin::LoginsController, type: :controller do
    include ApiHelper

	before(:all) do
  	    @email_account = FactoryBot.create(:email_account)
    end

    it 'login by email' do
        post :create, params: {
            "data": {
                "type": "email_account",
                "attributes": {
                    "email": @email_account.email,
                    "password": @email_account.password               
                }
            }
        }
        res = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(res["meta"]["token"]).not_to be_nil
    end
end