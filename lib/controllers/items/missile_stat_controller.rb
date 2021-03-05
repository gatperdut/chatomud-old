module ChatoMud
  module Controllers
    module Items
      class MissileStatController
        def initialize(server, item_controller, missile_stat)
          @server = server
          @item_controller = item_controller
          @missile_stat = missile_stat
        end

        def stowed_desc
          "#{@missile_stat.missile_type}s"
        end

        def missile_type
          @missile_stat.missile_type
        end

        def is_missile_type?(another_missile_type)
          missile_type == another_missile_type
        end
      end
    end
  end
end
