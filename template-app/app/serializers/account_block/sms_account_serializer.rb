module AccountBlock
  class SmsAccountSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :first_name,
      :last_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated
    ]

    attribute :full_name do |object|
      object.full_name
    end

    attribute :qr_image_url do |object|
      Rails.application.routes.url_helpers.rails_blob_url(object.qr_code.qr_code, host: base_url)
    end

  end
end
