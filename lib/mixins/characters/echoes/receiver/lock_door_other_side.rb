module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_lock_door_other_side(params)
            door_controller = params[:door]

            text = "#{door_controller.long_desc} is locked from the other side."

            tx(text)
          end
        end
      end
    end
  end
end
