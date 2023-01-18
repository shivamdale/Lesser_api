require 'spec_helper'
require 'rails_helper'

RSpec.describe BxBlockDashboard::RecycleBottlesController, type: :controller do
    before(:all) do
      @recycle_bottle = FactoryBot.create(:recycle_bottle)
    end

    it 'fetch all recycle bottles' do 
      get 'index'
      expect(response.status).to eq 200 
    end
end
