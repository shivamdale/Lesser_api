require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockDashboard::RecycleBottlesController, type: :controller do
	include ApiHelper
    before(:all) do
      @account = FactoryBot.create(:account)
      @recycle_bottle = @account.create_recycle_bottle(no_of_new_bottles: 1000, rewards: 10000 )
      @account_2 =  FactoryBot.create(:account)
    end

    let(:recycle_bottle_params) {
        {
            "no_of_bottes": Faker::Number.number(digits: 5),
            "size": 'large'
        }
    }

    it 'fetch all recycle bottles' do 
      authenticated_header(request, @account)
      get 'index'
      expect(response.status).to eq 200 
    end

    it 'should return nil if user does not have bottles' do
      authenticated_header(request, @account_2)
      get 'index'
      expect(response.status).to eq 404
    end

    it 'should create a levels' do
      authenticated_header(request, @account_2)
      post :create, params: recycle_bottle_params, as: :json
      res =JSON.parse(response.body)
      expect(response.status).to eq 200
    end
end
