require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::CitiesController, type: :controller do
    before(:all) do
      @age_group = FactoryBot.create(:city)
    end

    it 'fetch all age groups' do 
      get 'index'
      expect(response.status).to eq 200 
    end
end
