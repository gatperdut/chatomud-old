class AmountTemplateSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end
end
