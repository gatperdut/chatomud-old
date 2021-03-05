module ChatoMud
  module Mixins
    module BodyParts
      module Utils
        def simple_body_part_description(body_part)
          case body_part.to_sym
            when :head
              "head"
            when :face
              "face"
            when :leye
              "left eye"
            when :reye
              "right eye"
            when :neck
              "neck"
            when :lshoulder
              "left shoulder"
            when :rshoulder
              "right shoulder"
            when :larm
              "left arm"
            when :rarm
              "right arm"
            when :lelbow
              "left elbow"
            when :relbow
              "right elbow"
            when :lforearm
              "left forearm"
            when :rforearm
              "right forearm"
            when :lwrist
              "left wrist"
            when :rwrist
              "right wrist"
            when :lhand
              "left hand"
            when :rhand
              "right hand"
            when :chest
              "chest"
            when :abdomen
              "abdomen"
            when :lside
              "left side"
            when :rside
              "right side"
            when :back
              "back"
            when :groin
              "groin"
            when :lhip
              "left hip"
            when :rhip
              "right hip"
            when :lthigh
              "left thigh"
            when :rthigh
              "right thigh"
            when :lknee
              "left knee"
            when :rknee
              "right knee"
            when :lshin
              "left shin"
            when :rshin
              "right shin"
            when :lankle
              "left ankle"
            when :rankle
              "right ankle"
            when :lfoot
              "left foot"
            when :rfoot
              "right foot"
            else
              raise "unknown body location '#{body_part}'"
          end
        end

        def body_part_description(body_part)
          "the #{simple_body_part_description(body_part)}"
        end
      end
    end
  end
end
