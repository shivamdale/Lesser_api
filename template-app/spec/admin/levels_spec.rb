require 'rails_helper'
require 'spec_helper'

include Warden::Test::Helpers

RSpec.describe Admin::LevelsController, type: :controller do 
  render_views
  before(:each) do
    @password = Faker::Internet.password
    @admin_role = BxBlockRolesPermissions::AdminRole.create(name: Faker::Name.name)
    @admin = AdminUser.find_or_create_by(email: Faker::Internet.email, admin_role_id: @admin_role.id )
    @admin.password = @password
    @admin.save
    sign_in @admin
    @level = BxBlockLevel::Level.create(name: Faker::Name.name, min_rewards: Faker::Number.number, max_rewards: Faker::Number.number)
  end

  describe "Post#new" do
    let(:params) do {
      name: Faker::Name.name,
      min_rewards: Faker::Number.number,
      max_rewards: Faker::Number.number
    }
    end

    it "create level data" do
        post :new, params: params
        expect(response).to have_http_status(200)
    end
  end

  describe "Get#index" do
    it "show all data" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "Get#show" do
    it "show single data" do
       get :show, params: {id: @level.id}
       expect(response).to have_http_status(200)
    end
  end
  
  describe "Put,edit,delete" do
    let(:params) do {
      name: Faker::Name.name,
      min_rewards: Faker::Number.number,
      max_rewards: Faker::Number.number

    }
    end


    describe "Put,edit" do
      it "edit accounts" do
        put :edit, params: {id: @level.id}
        expect(response).to have_http_status(200)
      end
    end

    describe "Put,delete" do
      it "delete account" do
        delete :destroy, params: {id: @level.id}
        expect(response).to have_http_status(302)
      end
    end
  end
end