# BxBlockQrCodes::GenerateQr.call(data)

module BxBlockQrCodes
  module GenerateQr
    class << self
      def call(data)
        generate_qr_as_png(data)
      end

      private

      def generate_qr_as_png(data)
        qrcode = RQRCode::QRCode.new(data)
        qrcode.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: 'black',
          file: nil,
          fill: 'white',
          module_px_size: 6,
          resize_exactly_to: false,
          resize_gte_to: false
        )
      end
    end
  end
end
