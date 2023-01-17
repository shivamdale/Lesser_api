require 'rails_helper'

RSpec.describe BxBlockDashboard::RecycleBottle, type: :model do
  subject {BxBlockDashboard::RecycleBottle.new( no_of_bottles: Faker::Name.name, no_of_new_bottles: Faker::Number.number, CO2_emissions: Faker::Number.number, trees_planted: Faker::Number.number)}

    it "should has_many accounts" do
    t = BxBlockDashboard::RecycleBottle.reflect_on_association(:account)
    expect(t.macro).to eq(:belongs_to)
  end
end
