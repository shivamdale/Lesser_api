module BxBlockLevel
  class AccountLevelSerializer < BuilderBase::BaseSerializer

    attribute :present_level do |object|
      if object.account.recycle_bottle.level == object.level.name
        true
      else
        false
      end
    end

    attribute :level do |object|
      object.level.name
    end

    attribute :min_rewards do |object|
      object.level.min_rewards
    end

    attribute :max_rewards do |object|
      object.level.max_rewards
    end
  end
end
