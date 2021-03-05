module ChatoMud
  module Mixins
    # Classes including this module need a #model method which returns the entity they govern.
    module Describable
      module Common
        def matches_word(word)
          model.kwords.each do |kword|
            return true if kword.downcase.starts_with?(word)
          end
          false
        end
      end
    end
  end
end
