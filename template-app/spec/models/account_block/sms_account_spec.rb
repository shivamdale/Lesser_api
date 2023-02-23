require 'rails_helper'

RSpec.describe AccountBlock::SmsAccount, type: :model do

  it "should has many push notifications" do
    t = AccountBlock::Account.reflect_on_association(:push_notifications)
    expect(t.macro).to eq(:has_many)
  end

  it "callback Test" do
    @account = FactoryBot.create(:account)
    expect(@account.run_callbacks(:create)).to eq (true)
  end
end

