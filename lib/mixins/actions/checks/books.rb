module ChatoMud
  module Mixins
    module Actions
      module Checks
        module Boards
          def check_book_is_open(book_controller, message = nil)
            unless book_controller.is_open?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_is_closed(book_controller, message = nil)
            unless book_controller.is_closed?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_has_pages(book_controller, message = nil)
            unless book_controller.has_pages?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_can_flip(book_controller, message = nil)
            if book_controller.is_in_last_page?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_can_turn(book_controller, message = nil)
            if book_controller.is_in_first_page?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_page_is_within_bounds(book_controller, page, message = nil)
            unless book_controller.page_is_within_bounds?(page)
              tx(message) if message
              return false
            end
            true
          end

          def check_book_is_titled(book_controller, message = nil)
            unless book_controller.is_titled?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_is_not_titled(book_controller, message = nil)
            if book_controller.is_titled?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_page_is_blank(book_controller, message = nil)
            unless book_controller.find_post_controller_for_page.nil?
              tx(message) if message
              return false
            end
            true
          end

          def check_book_page_is_not_blank(book_controller, message = nil)
            if book_controller.find_post_controller_for_page.nil?
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
