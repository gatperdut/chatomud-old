module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_group_flee_start(params)
            emitter   = params[:emitter]
            followers = params[:followers]
            direction = params[:direction]

            tx(interpolate_me_other(emitter, "You order your group to start falling back #{direction}ward!", "#{emitter.short_desc} orders #{possessive(emitter.physical_attr_controller.gender)} group to start falling back #{direction}ward!"))

            followers.each do |follower|
              if follower.health_controller.is_conscious?
                tx(interpolate_me_other(follower, "Following the orders from #{emitter.short_desc}, you start falling back #{direction}ward!", "#{follower.short_desc} starts falling back #{direction}ward!"))
              else
                tx(interpolate_me_other(follower, "Your battered body remains still while the others start falling back.", "Unconscious, #{follower.short_desc} is unable to fall back!"))
              end
            end
          end
        end
      end
    end
  end
end
