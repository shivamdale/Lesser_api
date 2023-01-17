FactoryBot.define do
  factory :recycle_bottle, class: 'BxBlockDashboard::RecycleBottle' do
    no_of_bottles { 1 }
    no_of_new_bottles { 1 }
    CO2_emissions { Faker::Number.number }
    trees_planted {Faker::Number.number}
    account_id { FactoryBot.create(:account).id } 
  end
end