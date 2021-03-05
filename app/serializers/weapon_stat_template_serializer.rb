class WeaponStatTemplateSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end

  has_one :melee_stat_template

  has_one :ranged_stat_template
end
