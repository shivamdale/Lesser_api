require 'rails_helper'

RSpec.describe AccountBlock::Gender, type: :model do
  subject {AccountBlock::Gender.new(
    title: Faker::Name.name)
  }

  it "should has_many accounts" do
    t = AccountBlock::Gender.reflect_on_association(:accounts)
    expect(t.macro).to eq(:has_many)
  end
end

