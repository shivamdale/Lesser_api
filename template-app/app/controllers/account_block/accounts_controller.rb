module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, only: :search
    before_action :check_term_and_conditions, only: [:create]

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'
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

      when 'email_account'
        account_params = jsonapi_deserialize(params)

        query_email = account_params['email'].downcase
        account = EmailAccount.where('LOWER(email) = ?', query_email).first

        validator = EmailValidation.new(account_params['email'])

        return render json: {errors: [
          {account: 'Email invalid'},
        ]}, status: :unprocessable_entity if account || !validator.valid?

        @account = EmailAccount.new(jsonapi_deserialize(params))
        @account.activated = true
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')

        if @account.save
          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
            status: :unprocessable_entity
        end

      when 'social_account'
        @account = SocialAccount.new(jsonapi_deserialize(params))
        @account.password = @account.email
        if @account.save
          render json: SocialAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
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

    def search
      @accounts = Account.where(activated: true)
                    .where('first_name ILIKE :search OR '\
                           'last_name ILIKE :search OR '\
                           'email ILIKE :search', search: "%#{search_params[:query]}%")
      if @accounts.present?
        render json: AccountSerializer.new(@accounts, meta: {message: 'List of users.'
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: 'Not found any user.'}]}, status: :ok
      end
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def search_params
      params.permit(:query)
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
