FactoryBot.define do
  factory :age_group, class: 'AccountBlock::AgeGroup' do
    title { Faker::Name.name }
  end
end