module ChatoMud
  module Controllers
    class LockController
      def initialize(lock)
        @lock = lock
      end

      def lockers
        @lock.lockers
      end

      def lock
        @lock.locked = true
        @lock.save!
      end

      def unlock
        @lock.locked = false
        @lock.save!
      end

      def is_locked?
        @lock.locked
      end

      def is_unlocked?
        !@lock.locked
      end
    end
  end
end
