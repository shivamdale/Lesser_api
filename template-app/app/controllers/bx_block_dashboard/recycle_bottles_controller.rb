module BxBlockDashboard
  class RecycleBottlesController < ApplicationController
 
    def index
        recycle_bottle = @current_user.recycle_bottle
        if recycle_bottle.present?
          render json: BxBlockDashboard::RecycleBottleSerializer.new(recycle_bottle).serializable_hash, status: :ok
        else
          render json: { message: "bottle deposit details doesn't exists" }, status: :not_found
        end
    end

    def create
   	    rewards = 5*params[:no_of_bottes] if params[:size_of_bottles] == 'large'
   	    rewards = 2*params[:no_of_bottes] if params[:size_of_bottles] == 'small'
   	    recycle_bottle = @current_user.create_recycle_bottle(no_of_new_bottles: params[:no_of_bottes], rewards: rewards)
   	    if recycle_bottle.present?
   	        render json: BxBlockDashboard::RecycleBottleSerializer.new(recycle_bottle).serializable_hash, status: :ok
   	    else
   	    	render json: {errors: recycle_bottle.errors, status: :unprocessable_entity}
   	    end
    end
  end
end
  