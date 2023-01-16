module AccountBlock
   class CitiesController < ApplicationController
  		def index
  	  		cities = AccountBlock::City.all
  	  		render json: CitySerializer.new(cities).serializable_hash, status: :ok
  	    end
    end
end