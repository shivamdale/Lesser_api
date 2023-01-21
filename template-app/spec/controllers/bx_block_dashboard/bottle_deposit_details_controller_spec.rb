require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockDashboard::BottleDepositDetailsController, type: :controller do
	include ApiHelper
    before(:all) do
      @account = FactoryBot.create(:account)
      @recycle_bottle = @account.create_recycle_bottle(no_of_new_bottles: 1000, rewards: 10000 )
      @account_2 =  FactoryBot.create(:account)
    end

    it 'fetch all deposit details' do 
      authenticated_header(request, @account)
      get 'index'
      expect(response.status).to eq 200 
    end
end
