module ChatoMud
  module Mixins
    module Rooms
      module Echoes
        module Emitter
          def emit_action_echo(action, params)
            @character_controllers.each do |character_controller|
              character_controller.send("recv_#{action}", params)
            end
          end

          def emit_echo(emitter, text)
            @character_controllers.each do |character_controller|
              character_controller.tx(text) unless emitter == character_controller
            end
          end
        end
      end
    end
  end
end
