module AccountBlock
   class GendersController < ApplicationController
  		def index
  	  		genders = AccountBlock::Gender.all
  	  		render json: GenderSerializer.new(genders).serializable_hash, status: :ok
  	    end
    end
end