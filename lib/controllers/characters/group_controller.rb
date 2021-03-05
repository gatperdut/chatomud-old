module ChatoMud
  module Controllers
    module Characters
      class GroupController
        attr_reader :following

        def initialize(server, character_controller)
          @server               = server
          @character_controller = character_controller
          @following            = nil
          @followers            = []
        end

        def is_leading?(include_invisible = false)
          followers(include_invisible).count.positive?
        end

        def is_following?(include_invisible = false)
          return false unless @following.present?

          unless include_invisible
            return @following.visibility_controller.is_visible?
          end

          true
        end

        def is_grouped?(include_invisible = false)
          is_leading?(include_invisible) || is_following?(include_invisible)
        end

        def followers(include_invisible = false)
          @followers.select do |follower|
            include_invisible || follower.visibility_controller.is_visible?
          end
        end

        def group_leader
          return @following if is_following?

          @character_controller
        end

        def group_members(include_invisible = false)
          return @following.group_controller.group_members(include_invisible) if is_following?

          [@character_controller] + followers(include_invisible)
        end

        def is_member?(character_controller)
          group_members.include?(character_controller)
        end

        def list_group(include_invisible = false)
          unless is_grouped?(include_invisible)
            return "You do not have a group."
          end

          return @following.group_controller.list_group(include_invisible) if is_following?

          group_members(include_invisible).map do |character_controller|
            "<#{character_controller.health_bar}> #{character_controller.short_desc}"
          end.join("\n")
        end

        def follow(character_controller)
          @following.group_controller.remove_follower(@character_controller) if is_following?
          @following = character_controller
          character_controller.group_controller.be_followed(@character_controller)
        end

        def stop_following
          @following.group_controller.remove_follower(@character_controller) if @following.present?
          @following = nil
        end

        def be_followed(character_controller)
          if is_leading? || !is_grouped?
            add_follower(character_controller)
          else
            @following.group_controller.add_follower(character_controller)
          end
        end

        def all_followers_can_walk?(include_invisible)
          followers(include_invisible).reject(&:can_walk?).count.zero?
        end

        def add_follower(character_controller)
          @followers << character_controller
        end

        def remove_follower(character_controller)
          @followers.delete(character_controller)
        end

        def handle_teleport
          handle_gone
        end

        def handle_death
          handle_gone
        end

        def handle_quit
          handle_gone
        end

        def handle_fled
          handle_gone
        end

        private

        def handle_gone
          if is_following?
            stop_following
            return
          end

          return unless is_leading?

          followers_copy = followers(true).map(&:clone)

          followers_copy.each do |follower|
            follower.group_controller.stop_following
          end
        end
      end
    end
  end
end
