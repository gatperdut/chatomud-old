module ChatoMud
  module Mixins
    module Slots
      module Definition
        def all_slots
          regular_slots + hand_slots + [:void]
        end

        def regular_slots
          [
            :head, :neck,
            :torso, :about,
            :arms, :lshoulder, :rshoulder,
            :lwrist, :rwrist, :hands,
            :lfinger, :rfinger,
            :waist,
            :legs,
            :lankle, :rankle,
            :feet
          ]
        end

        def hand_slots
          wield_slots + [:rhand, :lhand]
        end

        def wield_slots
          [:w2hands, :wrhand, :wlhand]
        end

        def worn_slots
          all_slots - hand_slots
        end

        def opposite_hand_slot
          {
            rhand: :lhand,
            lhand: :rhand
          }
        end
      end
    end
  end
end
