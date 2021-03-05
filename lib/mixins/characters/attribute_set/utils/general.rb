module ChatoMud
  module Mixins
    module Characters
      module AttributeSet
        module Utils
          module General
            def attribute_value(attribute)
              @attribute_set.send(attribute)
            end

            def attribute_bonus(attribute)
              attr_value = attribute_value(attribute)

              @server.attribute_bonus_referrer.find(attr_value).bonus
            end

            def attribute_label(attribute)
              attr_value = attribute_value(attribute)

              @server.attribute_bonus_referrer.find(attr_value).label
            end

            def list_attributes
              text = ""
              self.class.all_attributes.each do |attribute|
                text << "#{attribute.to_s.magenta}: #{attribute_label(attribute)}"
                text << " (#{attribute_value(attribute)}/#{attribute_bonus(attribute)}) " # TODO: Hide this line, eventually.
              end
              text
            end
          end
        end
      end
    end
  end
end
