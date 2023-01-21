FactoryBot.define do
  factory :recycle_bottle, class: 'BxBlockDashboard::RecycleBottle' do
    no_of_new_bottles { 1000 }
    rewards { 10000 }
    account_id { FactoryBot.create(:account).id }
  end
end