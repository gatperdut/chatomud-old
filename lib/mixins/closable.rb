module ChatoMud
  module Mixins
    module Closable
      def open
        model.open = true
        model.save!
      end

      def close
        model.open = false
        model.save!
      end

      def is_open?
        model.open
      end

      def is_closed?
        !is_open?
      end
    end
  end
end
