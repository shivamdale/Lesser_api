require 'rails_helper'

RSpec.describe AccountBlock::City, type: :model do
  subject {AccountBlock::City.new(
    title: Faker::Name.name)
  }

  it "should has_many accounts" do
    t = AccountBlock::City.reflect_on_association(:accounts)
    expect(t.macro).to eq(:has_many)
  end
end

