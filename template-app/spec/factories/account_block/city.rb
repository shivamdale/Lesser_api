FactoryBot.define do
  factory :city, class: 'AccountBlock::City' do
    title { Faker::Address.city }
  end
end