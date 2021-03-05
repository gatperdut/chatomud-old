require "mixins/describable/common"
require "mixins/describable/closable"

require "mixins/slots/utils"

module ChatoMud
  module Mixins
    module Describable
      module Item
        include Common
        include Closable
        include Slots::Utils

        def short_desc
          text = model.short_desc.green
          text << light_source_lit_summary(false)    if is_light_source?
          text << book_summary(false)                if is_book?
          text << " (#{fillable_summary})"           if is_fillable?
          text << " (#{edible_summary})"             if is_edible?
          text << " (x#{stack_summary})"             if is_stackable? && @stack_controller.has_several?
          text << " (loaded with #{loaded_summary})" if is_weapon? && @weapon_stat_controller.is_ranged? && @weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
          text << " (bearing #{sheath_summary})"     if is_sheath? && @inventory_controller.has_content?
          text << " (bearing #{quiver_summary})"     if is_quiver? && @inventory_controller.has_content?
          text
        end

        def long_desc
          text = model.long_desc.green
          text << light_source_lit_summary(false)    if is_light_source?
          text << " (#{fillable_summary})"           if is_fillable?
          text << " (#{edible_summary})"             if is_edible?
          text << " (x#{stack_summary})"             if is_stackable?
          text << " (loaded with #{loaded_summary})" if is_weapon? && @weapon_stat_controller.is_ranged? && @weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
          text << " (bearing #{sheath_summary})"     if is_sheath? && @inventory_controller.has_content?
          text << " (bearing #{quiver_summary})"     if is_quiver? && @inventory_controller.has_content?
          text
        end

        def full_desc
          text = "#{model.full_desc}"
          text << "\nIt is #{fillable_summary}."           if is_fillable?
          text << "\nIt is #{edible_summary}."             if is_edible?
          text << "\n#{closable_summary}"                  if is_container? && @inventory_controller.is_closable?
          text << "\nIt is bearing #{sheath_summary}."     if is_sheath? && @inventory_controller.has_content?
          text << "\nIt is bearing #{quiver_summary}."     if is_quiver? && @inventory_controller.has_content?
          text << "\nIt is loaded with #{loaded_summary}." if is_weapon? && @weapon_stat_controller.is_ranged? && @weapon_stat_controller.ranged_stat_controller.inventory_controller.is_loaded?
          text << "\n#{light_source_lit_summary(true)}."   if is_light_source?
          text << "\n#{light_source_capacity_summary}."    if is_light_source? && light_source_controller.requires_fuel?
          text << "\n#{book_summary(true)}."               if is_book?
          text << "\n#{writing_summary}."                  if is_writing?
          text << "\n#{writing_implement_summary}."        if is_writing_implement?
          text << "\n#{ink_source_summary}."               if is_ink_source?
          text << "\nIt weighs #{weight} grams."
          text << "\n"
          text
        end

        def location(character_controller)
          case container_type
            when :room
              "on the ground"
            when :character
              owner_controller = @containing_inventory_controller.owner_controller
              pov = owner_controller == character_controller ? :personal : owner_controller.physical_attr_controller.gender
              "#{slot_description(slot, pov)}"
            when :item
              "inside #{@containing_inventory_controller.owner_controller.short_desc}"
          end
        end

        def light_source_lit_summary(full_sentence)
          lit = @light_source_controller.is_lit?

          if full_sentence
            if lit
              if @light_source_controller.is_eternal?
                summary = "It shimmers with an inner " << "light".white
              else
                summary = "It is " << "lit".red << " and will last #{@light_source_controller.lifetime_left_approximation}"
              end
            else
              if @light_source_controller.is_throw_away? && @light_source_controller.lifetime_left.zero?
                summary = "It is spent"
              else
                summary = "It is not lit and will last #{@light_source_controller.lifetime_left_approximation}"
              end
            end
          else
            if lit && !@light_source_controller.is_eternal?
              summary = " (" << "lit".red << ")"
            else
              summary = ""
            end
          end

          summary
        end

        def writing_implement_summary
          summary = "It could be used for writing"

          return summary if @writing_implement_controller.is_single_use?

          if @writing_implement_controller.is_charged?
            summary << " with the #{@writing_implement_controller.ink_type_name} it bears"
          else
            summary << ", were it dipped somewhere first"
          end

          summary
        end

        def ink_source_summary
          if @ink_source_controller.is_dipping_ink_source?
            summary = "It could be used to refill writing implements"
          else
            summary = "You could dip into it to get #{@ink_source_controller.ink_type_name} to write with"
          end

          if @ink_source_controller.has_no_charges_left?
            summary << ", but it is empty"
            return summary
          end

          charges = @ink_source_controller.charges

          if charges > 1
            summary << " about #{charges} more times"
          else
            summary << " one more time"
          end

          summary
        end

        def book_summary(full_sentence)
          if full_sentence
            summary = "It is #{@book_controller.open_close_string}"
            summary << " on page #{@book_controller.current_page}" if @book_controller.is_open? && @book_controller.has_pages?
            summary << ". It has #{book_controller.page_count_string} pages"
          else
            summary = " (#{@book_controller.open_close_string})"
          end

          summary
        end

        def writing_summary
          return "It is blank" unless @writing_controller.post_controller.has_content?

          "It has been written on with #{writing_controller.post_controller.ink_type_name}"
        end

        def light_source_capacity_summary
          text = "It is #{@light_source_controller.capacity_controller.current_portion_description}"

          if @light_source_controller.capacity_controller.has_some?
            text << " and will approximately last for #{@light_source_controller.lifetime_left}"
          end

          text
        end

        def fillable_summary
          return "empty" if @fluid_controller.is_empty?

          "#{@fluid_controller.current_portion_description} #{@fluid_controller.fluid_colorized}"
        end

        def edible_summary
          "#{@food_controller.current_portion_description}"
        end

        def sheath_summary
          @inventory_controller.list_sheathed_weapon
        end

        def quiver_summary
          @inventory_controller.list_missile_controllers
        end

        def loaded_summary
          @weapon_stat_controller.ranged_stat_controller.inventory_controller.list_loaded_missile
        end

        def stack_summary
          stack_controller.current
        end
      end
    end
  end
end
