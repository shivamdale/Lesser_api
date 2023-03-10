module BxBlockLogin
  class AccountAdapter
    include Wisper::Publisher

    def login_account(account_params)
      case account_params.type
      when 'sms_account'
        if account_params.full_phone_number.present?
          phone = Phonelib.parse(account_params.full_phone_number).sanitized
          account = AccountBlock::SmsAccount.find_by(
            full_phone_number: phone,
            activated: true)
        else
          email = account_params.email.downcase
          account = AccountBlock::SmsAccount.where('LOWER(email) = ?', email).where(:activated => true).first
        end
      when 'email_account'
        if account_params.full_phone_number.present?
          account = AccountBlock::EmailAccount.where(full_phone_number: account_params.full_phone_number).first
        else
          email = account_params.email.downcase
          account = AccountBlock::EmailAccount.where('LOWER(email) = ?', email).where(:activated => true).first
        end
      when 'social_account'
        account = AccountBlock::SocialAccount.find_by(
          email: account_params.email.downcase,
          unique_auth_id: account_params.unique_auth_id,
          activated: true)
      end

      unless account.present?
        broadcast(:account_not_found)
        return
      end

      if account.authenticate(account_params.password)
        token, refresh_token = generate_tokens(account.id)
        broadcast(:successful_login, account, token, refresh_token)
      else
        broadcast(:failed_login)
      end
    end

    def generate_tokens(account_id)
      [
        BuilderJsonWebToken.encode(account_id, 1.day.from_now, token_type: 'login'),
        BuilderJsonWebToken.encode(account_id, 1.year.from_now, token_type: 'refresh')
      ]
    end
  end
end
