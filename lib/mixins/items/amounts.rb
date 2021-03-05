module ChatoMud
  module Mixins
    module Items
      module Amounts
        def current
          model.current
        end

        def max
          model.max
        end

        def set_to_max
          model.current = model.max
        end

        def left_to_max
          model.max - model.current
        end

        def is_full?
          model.current == model.max
        end

        def is_empty?
          model.current.zero?
        end

        def has_some?
          model.current.positive?
        end

        def has_several?
          model.current > 1
        end

        def consume(amount)
          model.current = model.current - amount
          handle_consume
          model.save! if model.persisted?
        end

        def add(amount, fluid = nil)
          model.fluid = fluid if is_empty? && fluid
          model.current = model.current + amount
          model.save!
        end

        def has_at_least?(amount)
          model.current >= amount
        end

        def percentage(amount = :unspecified)
          amount = model.current if amount == :unspecified

          amount / model.max.to_f
        end
      end
    end
  end
end
