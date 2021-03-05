require "mixins/closable"
require "controllers/lock_controller"

module ChatoMud
  module Controllers
    module Inventories
      class LidController
        attr_reader :lock_controller

        include Mixins::Closable

        def initialize(lid)
          @lid = lid
          @lock_controller = @lid.lock ? Controllers::LockController.new(@lid.lock) : nil
        end

        def is_lockable?
          !!@lock_controller
        end

        def model
          @lid
        end
      end
    end
  end
end
