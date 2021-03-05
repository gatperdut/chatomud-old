class ItemTemplateSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end

  has_one :weapon_stat_template

  has_one :armor_stat_template

  has_one :shield_stat_template

  has_one :light_source_template

  has_one :food

  has_one :fluid

  has_one :stack

  has_one :inventory_template
end
