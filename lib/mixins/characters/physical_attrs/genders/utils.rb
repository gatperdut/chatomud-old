module ChatoMud
  module Mixins
    module Characters
      module PhysicalAttrs
        module Genders
          module Utils
            def to_be(gender)
              return "is"  if gender == :male
              return "is"  if gender == :female
              return "is"  if gender == :neuter
              return "are" if gender == :personal

              raise "Trying to find to_be with unknown gender."
            end

            def to_have(gender)
              return "has"  if gender == :male
              return "has"  if gender == :female
              return "has"  if gender == :neuter
              return "have" if gender == :personal

              raise "Trying to find to_have with unknown gender."
            end

            def personal(gender)
              return "he"  if gender == :male
              return "she" if gender == :female
              return "it"  if gender == :neuter
              return "you" if gender == :personal

              raise "Trying to find personal pronoun with unknown gender."
            end

            def possessive(gender)
              return "his"  if gender == :male
              return "her"  if gender == :female
              return "its"  if gender == :neuter
              return "your" if gender == :personal

              raise "Trying to find possessive pronoun with unknown gender."
            end

            def objective(gender)
              return "him"  if gender == :male
              return "her"  if gender == :female
              return "it"  if gender == :neuter
              return "you" if gender == :personal

              raise "Trying to find objective pronoun with unknown gender."
            end

            def voice(gender)
              return "male"    if gender == :male
              return "female"  if gender == :female
              return ""        if gender == :neuter

              raise "Trying to find voice with unknown gender."
            end
          end
        end
      end
    end
  end
end
