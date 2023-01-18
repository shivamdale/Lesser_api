module BxBlockDashboard
  class RecycleBottleSerializer < BuilderBase::BaseSerializer
    attributes *[
    :id,
    :no_of_bottles,
    :CO2_emissions,
    :trees_planted
    ]
  end
end
