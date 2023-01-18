module BxBlockDashboard
  class RecycleBottlesController < ApplicationController

    def index
      recycle_bottle = BxBlockDashboard::RecycleBottle.all
      render json: BxBlockDashboard::RecycleBottleSerializer.new(recycle_bottle).serializable_hash, status: :ok
    end
  end
end
  