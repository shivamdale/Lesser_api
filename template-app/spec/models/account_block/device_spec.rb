require 'rails_helper'

RSpec.describe AccountBlock::Device, type: :model do
  subject {AccountBlock::Device.new(
    device_id: Faker::Name.name)
  }

  it "should belongs_to account" do
    t = AccountBlock::Device.reflect_on_association(:account)
    expect(t.macro).to eq(:belongs_to)
  end
end

