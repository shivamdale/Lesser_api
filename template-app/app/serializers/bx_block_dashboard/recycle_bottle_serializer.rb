module BxBlockDashboard
  class RecycleBottleSerializer < BuilderBase::BaseSerializer
  	  include FastJsonapi::ObjectSerializer
    attributes *[
    :id,
    :no_of_bottles,
    :CO2_emissions,
    :trees_planted,
    :rewards,
    :level
    ]
    attribute :max_number do |object|
      if object.level.present?
        level = BxBlockLevel::Level.find_by(name: object.level)
        level.max_rewards
      end
    end
  end
end
