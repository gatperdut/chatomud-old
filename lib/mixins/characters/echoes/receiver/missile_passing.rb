module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_missile_passing(params)
            direction = params[:direction]
            missile   = params[:missile]

            return unless can_see_action?(@character_controller)

            text = "#{missile.short_desc} races #{direction}ward!"

            tx(text)
          end
        end
      end
    end
  end
end
