require "mixins/characters/gifts/definition"

module ChatoMud
  module Mixins
    module Characters
      module Gifts
        module Gifted
          extend Mixins::Characters::Gifts::Definition

          all_gifts.each do |gift|
            define_method("has_gift_#{gift}?") do
              model.gifts.include?(gift)
            end
          end
        end
      end
    end
  end
end
