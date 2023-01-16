FactoryBot.define do
  factory :gender, class: 'AccountBlock::Gender' do
    title { Faker::Gender.binary_type }
  end
end