FactoryBot.define do
  factory :account, class: 'AccountBlock::Account' do
    first_name {Faker::Name.name}
    last_name {Faker::Name.name}
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 12, mix_case: true, special_characters: true)}
    city_id {FactoryBot.create(:city).id}
    age_group_id {FactoryBot.create(:age_group).id}
    gender_id {FactoryBot.create(:gender).id}
    full_phone_number { Faker::Base.numerify('+91##########')}
  end
end