module ChatoMud
  module Mixins
    module Items
      module Book
        def title
          post_controller = find_post_controller_for_page(0)

          return nil if post_controller.nil?

          post_controller.content
        end

        def is_titled?
          title.present?
        end

        def current_page
          model.current_page
        end

        def page_count
          model.page_count
        end

        def open_close_string
          is_open? ? "open" : "closed"
        end

        def page_count_string
          return "no" unless has_pages?

          page_count.to_s
        end

        def is_open?
          current_page.nil? || current_page.positive?
        end

        def is_closed?
          !is_open?
        end

        def is_in_last_page?
          current_page == page_count
        end

        def is_in_first_page?
          current_page == 1
        end

        def page_is_within_bounds?(page)
          page >= 1 && page <= page_count
        end

        def has_pages?
          page_count.positive?
        end

        def has_no_pages?
          page_count.zero?
        end

        def open
          model.current_page = page_count.positive? ? 1 : nil
          model.save!
        end

        def close
          model.current_page = 0
          model.save!
        end

        def flip(page = nil)
          page = model.current_page + 1 if page.nil?
          model.current_page = page
          model.save!
        end

        def turn
          model.current_page = model.current_page - 1
          model.save!
        end

        def is_wipeable?
          false
        end
      end
    end
  end
end
