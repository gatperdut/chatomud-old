module ChatoMud
  module Spawners
    module Factories
      class BooksFactory
        def initialize(server)
          @server = server
        end

        def instantiate(book_template)
          book_attributes = book_template.attributes.symbolize_keys.except(:id, :item_template_id)

          book_attributes[:open]         = false
          book_attributes[:current_page] =   nil
          book_attributes[:title]        =   nil

          book = Book.new(book_attributes)

          book
        end
      end
    end
  end
end
