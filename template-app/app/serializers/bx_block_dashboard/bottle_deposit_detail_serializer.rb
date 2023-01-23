module BxBlockDashboard
  class BottleDepositDetailSerializer < BuilderBase::BaseSerializer
  	include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :no_of_bottle,
      :created_at
    ]
  end
end
