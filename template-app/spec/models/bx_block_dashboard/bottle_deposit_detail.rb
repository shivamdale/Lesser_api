require 'rails_helper'

RSpec.describe BxBlockDashboard::BottleDepositDetail, type: :model do
	before(:all) do
      @recycle_bottle = FactoryBot.create(:recycle_bottle)
    end
    subject {BxBlockDashboard::BottleDepositDetail.new( no_of_bottle: Faker::Number.number, recycle_bottle_id: @recycle_bottle.id)}

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should belongs_to recycle bottle" do
      t = BxBlockDashboard::RecycleBottle.reflect_on_association(:recycle_bottle)
      expect(t.macro).to eq(:belongs_to)
    end
end
