require "mixins/describable/common"

module ChatoMud
  module Mixins
    # Classes including this module need a #model method which returns the entity they govern.
    module Describable
      module Door
        include Common

        def short_desc
          model.short_desc.light_black
        end

        def long_desc
          model.long_desc.light_black
        end

        def full_desc
          model.full_desc
        end
      end
    end
  end
end
