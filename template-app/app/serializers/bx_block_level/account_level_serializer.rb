module BxBlockLevel
  class AccountLevelSerializer < BuilderBase::BaseSerializer

    attribute :rewards do |object|
      object.account.recycle_bottle.rewards
    end

    attribute :level do |object|
      object.level.name
    end

    attribute :level_list do |object|
      BxBlockLevel::Level.all.each do |level|
        LevelSerializer.new(level)
      end
    end
  end
end
