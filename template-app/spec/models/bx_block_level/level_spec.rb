require 'rails_helper'

RSpec.describe BxBlockLevel::Level, type: :model do
  subject {BxBlockLevel::Level.new( name: Faker::Name.name, min_rewards: Faker::Number.number, max_rewards: Faker::Number.number)}

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a max rewards" do
      subject.max_rewards = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a min rewards" do
      subject.min_rewards = nil
      expect(subject).to_not be_valid
    end

    it "should has many accounts" do
      t = BxBlockLevel::Level.reflect_on_association(:accounts)
      expect(t.macro).to eq(:has_many)
    end

    it "should has many account_levels" do
      t = BxBlockLevel::Level.reflect_on_association(:account_levels)
      expect(t.macro).to eq(:has_many)
    end
end
