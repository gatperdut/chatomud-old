module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_open_door_other_side(params)
            door_controller = params[:door]

            text = "#{door_controller.long_desc} is opened from the other side."

            tx(text)
          end
        end
      end
    end
  end
end
