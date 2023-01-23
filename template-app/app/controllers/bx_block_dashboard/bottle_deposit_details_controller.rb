module BxBlockDashboard
  class BottleDepositDetailsController < ApplicationController

    def index
      bottle_deposit_details = @current_user.recycle_bottle.bottle_deposit_details
      if bottle_deposit_details.present?
        render json: BxBlockDashboard::BottleDepositDetailSerializer.new(bottle_deposit_details).serializable_hash, status: :ok
      else
        render json: {
          message: "bottle deposit details doesn't exists"
      }, status: :not_found
      end
    end
  end
end
  