module ChatoMud
  module Mixins
    module Characters
      module Health
        module WoundManager
          def wounded?
            @wound_controllers.length.positive?
          end

          def autoheal_wounds
            @wound_controllers.select(&:will_auto_heal?)
          end

          def add_wound_controller(wound_controller)
            @wound_controllers << wound_controller
          end

          def remove_wound_controller(wound_controller)
            @wound_controllers.delete(wound_controller)
          end

          def list_wounds(_gender)
            @wound_controllers.map(&:description).to_sentence
          end

          def wounds_by_body_part(body_part, lodged_missile)
            @wound_controllers.select do |wound_controller|
              wound_controller.in_body_part?(body_part.to_sym) && [:indifferent, lodged_missile].include?(wound_controller.has_missile_lodged?)
            end
          end
        end
      end
    end
  end
end
