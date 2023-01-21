module BxBlockLevel
   class AccountLevelsController < ApplicationController
   	    include BuilderJsonWebToken::JsonWebTokenValidation

        before_action :validate_json_web_token
        before_action :current_user

  		def index
  	  		account_levels = @current_user.account_levels
  	  		if account_levels.present?
  	  		  render json: AccountLevelSerializer.new(account_levels).serializable_hash, status: :ok
  	  		else
                render json: { message: "bottle deposit details doesn't exists" }, status: :not_found
  	  		end
  	    end

  	    private
  	    def current_user
	        return unless @token
	        @current_user ||= AccountBlock::Account.find(@token.id)
	    end
    end
end