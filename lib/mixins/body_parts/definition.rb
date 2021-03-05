module ChatoMud
  module Mixins
    module BodyParts
      module Definition
        def all_body_parts
          [
            :head, :face, :leye, :reye, :neck,
            :lshoulder, :rshoulder,
            :larm, :rarm, :lelbow, :relbow, :lforearm, :rforearm, :lwrist, :rwrist, :lhand, :rhand,
            :chest, :abdomen, :lside, :rside, :back, :groin,
            :lhip, :rhip, :lthigh, :rthigh, :lknee, :rknee,
            :lshin, :rshin, :lankle, :rankle, :lfoot, :rfoot
          ]
        end
      end
    end
  end
end
