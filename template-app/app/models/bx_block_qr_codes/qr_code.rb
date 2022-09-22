module BxBlockQrCodes
  class QrCode < ApplicationRecord
    self.table_name = :qr_codes

    has_one_attached :qr_code

    belongs_to :qrable, polymorphic: true, optional: true

    before_save :generate_qr_for_qrable, if: :will_save_change_to_qrable_id?
    validate :validate_qrable

    def generate_code(qr_data)
      qr_code_data = BxBlockQrCodes::GenerateQr.call(qr_data.to_json)
      qr_code.attach(io: StringIO.new(qr_code_data.to_s), filename: 'qr_code.png')
    end

    private

    def validate_qrable
      qrable
    rescue NameError
      self.errors.add(:qrable, "Cannot associate QR code with #{qrable_type}:#{qrable_id}")
    end

    def generate_qr_for_qrable
      qr_data = qrable.try(:qr_data)

      if qr_data
        generate_code(qr_data)
      end
    end
  end
end
