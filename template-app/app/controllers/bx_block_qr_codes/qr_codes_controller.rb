module BxBlockQrCodes
  class QrCodesController < ApplicationController
    def show
      if find_qr.present?
        render json: BxBlockQrCodes::QrCodeSerializer.new(find_qr).serializable_hash
      else
        render json: {errors: 'qr code not found.'}, status: :not_found
      end
    end

    def create
      if new_qr&.save
        render :json => BxBlockQrCodes::QrCodeSerializer.new(new_qr).serializable_hash
      else
        render json: {errors: format_activerecord_errors(new_qr.errors)},
               status: :unprocessable_entity
      end
    end

    private

    def find_qr
      @find_qr ||= if params[:type]
        BxBlockQrCodes::QrCode.find_by(qrable_id: params[:id], qrable_type: params[:type])
      else
        BxBlockQrCodes::QrCode.find_by(id: params[:id])
      end
    end

    def new_qr
      @new_qr ||= begin
                    qr = BxBlockQrCodes::QrCode.new
                    if params[:data]
                      qr.generate_code(params[:data])
                      qr
                    elsif params[:id] && params[:type]
                      qr.qrable_id = params[:id]
                      qr.qrable_type = params[:type]
                      qr
                    end
                  end
    end
  end
end
