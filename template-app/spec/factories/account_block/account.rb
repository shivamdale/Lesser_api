FactoryBot.define do
  factory :account, class: 'AccountBlock::Account' do
    first_name {Faker::Name.name}
    last_name {Faker::Name.name}
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    city_id {FactoryBot.create(:city).id}
    age_group_id {FactoryBot.create(:age_group).id}
    gender_id {FactoryBot.create(:gender).id}
    full_phone_number { Faker::PhoneNumber.phone_number }
  end
end