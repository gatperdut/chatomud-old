module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_follow_proxy(params)
            emitter     = params[:emitter]
            target      = params[:target]

            final_leader = target.group_controller.following

            text = interpolate_me_others(emitter, final_leader, "You start following the leader of #{target.short_desc}, #{final_leader.short_desc}.", "#{emitter.short_desc} starts following you.", "#{emitter.short_desc} starts following #{final_leader.short_desc}.")

            tx(text)
          end
        end
      end
    end
  end
end
