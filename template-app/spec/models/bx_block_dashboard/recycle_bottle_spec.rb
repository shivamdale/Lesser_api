require 'rails_helper'

RSpec.describe BxBlockDashboard::RecycleBottle, type: :model do
  before(:all) do
      @account = FactoryBot.create(:account)
  end
  subject {BxBlockDashboard::RecycleBottle.new( no_of_bottles: Faker::Number.number, no_of_new_bottles: Faker::Number.number, CO2_emissions: Faker::Number.number, trees_planted: Faker::Number.number, account_id: @account.id)}

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should belongs_to accounts" do
      t = BxBlockDashboard::RecycleBottle.reflect_on_association(:account)
      expect(t.macro).to eq(:belongs_to)
    end

    it "should has many bottle deposit details" do
      t = BxBlockDashboard::RecycleBottle.reflect_on_association(:bottle_deposit_details)
      expect(t.macro).to eq(:has_many)
    end
end
