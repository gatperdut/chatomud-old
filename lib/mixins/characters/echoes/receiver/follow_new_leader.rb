module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_follow_new_leader(params)
            group_members = params[:group_members]
            target        = params[:target]

            leader = group_members[0]
            rest   = group_members.drop(1)

            tx(interpolate_me_others(leader, target, "You hand the leadership of the group to #{target.short_desc}.", "#{leader.short_desc} hands the leadership of the group to you.", "#{leader.short_desc} hands the leadership of the group to #{target.short_desc}."))

            rest.each do |group_member|
              tx(interpolate_me_other(group_member, "You fall into stride with the new group leader, #{target.short_desc}.", "#{group_member.short_desc} falls into stride with #{target.short_desc}."))
            end
          end
        end
      end
    end
  end
end
