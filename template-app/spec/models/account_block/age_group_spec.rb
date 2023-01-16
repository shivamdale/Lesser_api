require 'rails_helper'

RSpec.describe AccountBlock::AgeGroup, type: :model do
  subject {AccountBlock::AgeGroup.new(
    title: Faker::Name.name)
  }

  it "should has_many accounts" do
    t = AccountBlock::AgeGroup.reflect_on_association(:accounts)
    expect(t.macro).to eq(:has_many)
  end
end

