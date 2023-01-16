module AccountBlock
   class AgeGroupsController < ApplicationController
  		def index
  	  		age_groups = AccountBlock::AgeGroup.all
  	  		render json: AgeGroupSerializer.new(age_groups).serializable_hash, status: :ok
  	    end
    end
end