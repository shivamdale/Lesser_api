module AccountBlock
  class CitySerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :title
    ]
  end
end
