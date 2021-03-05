module ChatoMud
  module Mixins
    module Characters
      module Status
        module Markers
          module Aiming
            def aim_marker
              case @aim_controller.aim_stage
                when :not_aiming
                  ""
                when :low
                  "<" << "aiming".red << ">"
                when :medium
                  "<" << "aiming".red << ">"
                when :high
                  "<" << "aiming".yellow << ">"
                when :aimed
                  "<" << "aimed".green << ">"
                else
                  raise "unknown aim stage"
              end
            end

            def load_marker
              if @load_controller.is_loading? && !@load_controller.is_pre_finish?
                "<" << "loading".yellow << ">"
              else
                ""
              end
            end

            def holding_load_marker
              if @load_controller.is_holding_load? && !@aim_controller.is_aiming?
                "<" << "holding".yellow << ">"
              else
                ""
              end
            end
          end
        end
      end
    end
  end
end
