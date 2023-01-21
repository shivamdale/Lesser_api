FactoryBot.define do
  factory :contact, class: 'BxBlockProfile::Contact' do
    first_name { "test" }
    last_name {  "test" }
    contact_type  { "test@yopmail.com" }
    message { "This is for testing" }
  end
end
