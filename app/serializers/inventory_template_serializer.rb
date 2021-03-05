class InventoryTemplateSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end

  has_one :lid_template
end
