class CraftStepSerializer < ActiveModel::Serializer
  def attributes(*_args)
    object.attributes.symbolize_keys
  end

  has_one :craft_test

  has_many :craft_item_results
end
