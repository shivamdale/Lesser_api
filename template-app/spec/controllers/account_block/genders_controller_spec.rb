require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::GendersController, type: :controller do
    before(:all) do
      @age_group = FactoryBot.create(:gender)
    end

    it 'fetch all age groups' do 
      get 'index'
      expect(response.status).to eq 200 
    end
end
