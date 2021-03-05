module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_eat(params)
            emitter = params[:emitter]
            target = params[:target]
            amount = params[:amount]

            text = interpolate_me_other(emitter, "You eat ", "#{emitter.short_desc} eats ")

            text << "#{target.food_controller.taken_portion_description(amount)} #{target.short_desc}."

            tx(text)
          end
        end
      end
    end
  end
end
