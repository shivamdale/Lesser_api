module BxBlockProfile
  module ChangePasswordCommand
    extend self

    def execute(account_id, password, new_password, password_confirmation)
      validator = ChangePasswordValidator
        .new(account_id, password, new_password)

      account = validator.account

      unless validator.valid?
        return [:unprocessable_entity, validator.errors.full_messages]
      end
      return [:created, account] if update_password(account, new_password, password_confirmation)
      [:unprocessable_entity, [account.errors.full_messages]]
    end

    private

    def update_password(account, new_password, password_confirmation)
      account.update({:password => new_password, :password_confirmation => password_confirmation})
    end
  end
end
