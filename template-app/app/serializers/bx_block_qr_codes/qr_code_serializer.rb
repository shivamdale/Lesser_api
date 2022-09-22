module BxBlockQrCodes
  class QrCodeSerializer < BuilderBase::BaseSerializer
    attributes :id, :qrable_type, :qrable_id, :created_at, :updated_at

    attribute :qr_code do |qr_code|
      attachment = qr_code.qr_code.attachment

      if attachment
        Rails.application.routes.url_helpers.rails_blob_url(qr_code.qr_code, host: base_url)
      end
    end
  end
end
