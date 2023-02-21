module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :check_term_and_conditions, only: [:create]

    def create
      if params[:data][:type] ==  'sms_account'
        @account = SmsAccount.new(jsonapi_deserialize(params))
        @account.activated = true
        if @account.save
          render json: SmsAccountSerializer.new(@account, meta: {
            token: encode(@account.id)
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
            status: :unprocessable_entity
        end
      else
        render json: {errors: [
          {account: 'Invalid Account Type'},
        ]}, status: :unprocessable_entity
      end
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << {attribute => error}
      end
      result
    end

    def check_term_and_conditions
      render json: {errors: "please accept the term and condition"}, status: :unprocessable_entity unless params["data"]["attributes"][:term_and_conditions] == true
    end
  end
end
