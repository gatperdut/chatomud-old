module ChatoMud
  module Mixins
    # Classes including this module need a #model method which returns the entity they govern.
    # Maybe use this for a 'dup' command duplicating a npc (so far only used to find items' templates)
    module Instantiable
      module Item
        def template
          model.item_template
        end
      end
    end
  end
end
