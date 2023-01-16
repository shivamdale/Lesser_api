require 'spec_helper'
require 'rails_helper'

RSpec.describe AccountBlock::AgeGroupsController, type: :controller do
    before(:all) do
      @age_group = FactoryBot.create(:age_group)
    end

    it 'fetch all age groups' do 
      get 'index'
      expect(response.status).to eq 200 
    end
end
