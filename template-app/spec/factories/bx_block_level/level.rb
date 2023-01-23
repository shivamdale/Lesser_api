FactoryBot.define do
  factory :level, class: 'BxBlockLevel::Level' do
    name { 'Seed' }
    min_rewards {  0 }
    max_rewards  { 1000 }
  end
end
