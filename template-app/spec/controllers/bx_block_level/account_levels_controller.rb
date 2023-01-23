require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockLevel::AccountLevelsController, type: :controller do
	include ApiHelper
    before(:all) do
      @level = FactoryBot.create(:level)
      @account = FactoryBot.create(:account)
      @recycle_bottle = @account.create_recycle_bottle(no_of_new_bottles: 1000, rewards: 900 )
      @account_2 = FactoryBot.create(:account)
    end

    it 'fetch all levels for perticular account' do 
      authenticated_header(request, @account)
      get 'index'
      expect(response.status).to eq 200
    end


    it 'fetch all levels for perticular account' do 
      authenticated_header(request, @account_2)
      get 'index'
      expect(response.status).to eq 404
    end
end
