require 'rails_helper'

RSpec.describe AccountBlock::Account, type: :model do
  subject {AccountBlock::Account.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    full_phone_number: Faker::PhoneNumber.phone_number,
    password: Faker::Internet.password)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
 
  it "should have one blacklist_user" do
    t = AccountBlock::Account.reflect_on_association(:blacklist_user)
    expect(t.macro).to eq(:has_one)
  end

  it "should belongs_to role" do
    t = AccountBlock::Account.reflect_on_association(:role)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belongs_to gender" do
    t = AccountBlock::Account.reflect_on_association(:gender)
    expect(t.macro).to eq(:belongs_to)
  end
  
  it "should belongs_to city" do
    t = AccountBlock::Account.reflect_on_association(:city)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belongs_to age group" do
    t = AccountBlock::Account.reflect_on_association(:age_group)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should has_one age recycle bottle" do
    t = AccountBlock::Account.reflect_on_association(:recycle_bottle)
    expect(t.macro).to eq(:has_one)
  end

  it "should has_many levels" do
    t = AccountBlock::Account.reflect_on_association(:levels)
    expect(t.macro).to eq(:has_many)
  end

  it "should has_many account levels" do
    t = AccountBlock::Account.reflect_on_association(:account_levels)
    expect(t.macro).to eq(:has_many)
  end
end

