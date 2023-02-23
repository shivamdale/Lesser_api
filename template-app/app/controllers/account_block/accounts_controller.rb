module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :check_term_and_conditions, only: [:create]

    before_action :validate_json_web_token, only: [:get_details, :edit_profile,:delete_user]
    before_action :current_user, only: [:get_details,:delete_user, :edit_profile]

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

    def get_details
      render json: SmsAccountSerializer.new(@current_user).serializable_hash, status: :ok
    end

    def edit_profile
    @current_user.update(user_params)
    render json: SmsAccountSerializer.new(@current_user).serializable_hash, status: :ok
    end
    
    def delete_user
    @current_user.destroy
    render json: {message: "user deleted"}, status: :created
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

      def current_user
        return unless @token
        @current_user ||= AccountBlock::Account.find(@token.id)
      end

      def user_params
        params.require(:data)[:attributes].permit(:email,:first_name,:last_name,:full_phone_number,:city_id,:gender_id,:age_group_id)
      end

  end
end
