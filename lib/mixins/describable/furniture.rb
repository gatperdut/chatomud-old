require "mixins/describable/common"
require "mixins/describable/closable"

require "mixins/slots/utils"

module ChatoMud
  module Mixins
    module Describable
      module Furniture
        include Common
        include Closable
        include Slots::Utils

        def short_desc
          model.short_desc.cyan
        end

        def long_desc
          model.long_desc.cyan
        end

        def full_desc
          text = "#{model.full_desc}"
          text << "\n#{closable_summary}" if is_container? && @inventory_controller.is_closable?
          text << "\n"

          text
        end
      end
    end
  end
end
