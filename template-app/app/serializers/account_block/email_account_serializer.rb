module AccountBlock
  class EmailAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :first_name,
      :last_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :term_and_conditions,
      :district
    ]

    attribute :gender do |object|
      object.gender.title if object.gender.present?
    end

    attribute :age_group do |object|
      object.age_group.title if object.age_group.present?
    end

    attribute :city do |object|
      object.city.title if object.city.present?
    end
  end
end
