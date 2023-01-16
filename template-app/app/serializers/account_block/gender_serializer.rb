module AccountBlock
  class GenderSerializer < BuilderBase::BaseSerializer
    attributes *[
      :id,
      :title
    ]
  end
end
