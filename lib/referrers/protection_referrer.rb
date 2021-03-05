module ChatoMud
  module Referrers
    class ProtectionReferrer
      def initialize
        @entries = Protection.all.to_a
      end

      def find(level)
        raise "invalid protection level #{level}" unless (1..20).include?(level)

        @entries.bsearch do |entry|
          entry.level >= level
        end
      end
    end
  end
end
