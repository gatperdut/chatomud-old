module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_ranged_attack(params)
            @target       = params[:target]
            attack        = params[:attack]
            missile       = params[:missile]
            direction     = params[:direction]
            @body_part    = params[:body_part]
            dest_room     = params[:dest_room]

            text = ""

            if dest_room == :target && direction.present?
              text << "#{missile.short_desc} races from #{opposite_as_from(direction)} toward "
              text << interpolate_me_other(@target, "you!\n", "#{@target.short_desc}!\n")
            end

            if attack.connects
              handle_ranged_connecting_attack(text)
            else
              handle_ranged_missed_attack(text)
            end

            tx(text)
          end

          def handle_ranged_missed_attack(text)
            text << "It misses."
          end

          def handle_ranged_connecting_attack(text)
            text << "It lodges in "
            text << interpolate_me_other(@target, "your #{@body_part}.", "#{possessive(@target.physical_attr_controller.gender)} #{simple_body_part_description(@body_part)}.")
          end
        end
      end
    end
  end
end
