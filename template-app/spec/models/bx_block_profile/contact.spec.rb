require 'rails_helper'

RSpec.describe BxBlockProfile::Contact, type: :model do
  context "validation" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :contact_type }
    it { should validate_presence_of :message }
  end
end
