require 'rails_helper'

RSpec.describe AccountLevel, type: :model do
  before(:all) do
    @account = FactoryBot.create(:account)
    @recycle_bottle = FactoryBot.create(:recycle_bottle)
  end
  subject {AccountLevel.new( account_id: @account.id, recycle_bottle_id: @recycle_bottle.id, present_level: true)}

  it "is valid with valid attributes" do
      expect(subject).to be_valid
  end
  it "should belongs to accounts" do
    t = AccountLevel.reflect_on_association(:account)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belongs to level" do
    t = AccountLevel.reflect_on_association(:level)
    expect(t.macro).to eq(:belongs_to)
  end
end
