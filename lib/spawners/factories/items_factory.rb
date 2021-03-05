module ChatoMud
  module Spawners
    module Factories
      class ItemsFactory
        def initialize(server)
          @server = server
        end

        def instantiate(item_template)
          basic_attributes = @server.basic_attributes_factory.instantiate(item_template)

          item = Item.new(basic_attributes)

          item.inventory         = @server.inventories_factory.instantiate(item_template.inventory_template)                if item_template.inventory_template

          item.horn_property     = @server.horn_properties_factory.instantiate(item_template.horn_property_template)        if item_template.horn_property_template

          item.weapon_stat       = @server.weapon_stats_factory.instantiate(item_template.weapon_stat_template)             if item_template.weapon_stat_template

          item.armor_stat        = @server.armor_stats_factory.instantiate(item_template.armor_stat_template)               if item_template.armor_stat_template

          item.shield_stat       = @server.shield_stats_factory.instantiate(item_template.shield_stat_template)             if item_template.shield_stat_template

          item.light_source      = @server.light_sources_factory.instantiate(item_template.light_source_template)           if item_template.light_source_template

          item.missile_stat      = @server.missile_stats_factory.instantiate(item_template.missile_stat_template)           if item_template.missile_stat_template

          item.writing_implement = @server.writing_implements_factory.instantiate(item_template.writing_implement_template) if item_template.writing_implement_template

          item.book              = @server.books_factory.instantiate(item_template.book_template)                           if item_template.book_template

          item.ink_source        = @server.ink_sources_factory.instantiate(item_template.ink_source_template)               if item_template.ink_source_template

          %w[stack food fluid].each do |amount_key|
            amount_template = item_template.send(amount_key)

            item.send(amount_key + "=", @server.amounts_factory.instantiate(amount_template)) if amount_template
          end

          item.item_template = item_template

          item
        end
      end
    end
  end
end
