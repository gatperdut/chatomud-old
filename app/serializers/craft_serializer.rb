class CraftSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end

  has_many :craft_ingredients

  has_many :craft_steps
end
