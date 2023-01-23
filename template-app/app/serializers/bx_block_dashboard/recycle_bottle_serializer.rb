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
  end
end
