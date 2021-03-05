module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Boards
          def check_board_page_is_within_bounds(board_controller, page, message = nil)
            unless page <= board_controller.page_count
              tx(message) if message
              return false
            end
            true
          end

          def check_board_has_content(board_controller, message = nil)
            if board_controller.empty?
              tx(message) if message
              return false
            end
            true
          end

          def check_board_index_is_within_bounds(board_controller, index, message = nil)
            if index < 1 || index > board_controller.post_count
              tx(message) if message
              return false
            end
            true
          end
        end
      end
    end
  end
end
