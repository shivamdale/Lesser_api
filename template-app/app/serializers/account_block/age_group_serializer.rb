module AccountBlock
  class AgeGroupSerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :title
    ]
  end
end
