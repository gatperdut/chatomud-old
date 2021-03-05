module ChatoMud
  module Actions
    class Mudstats < BaseAction
      def exec
        text =  @server.superareas_handler.report
        text << @server.areas_handler.report
        text << @server.rooms_handler.report
        text << @server.items_handler.report
        text << @server.doors_handler.report
        text << @server.entities_handler.report
        text << @server.characters_handler.report
        tx(text)
      end
    end
  end
end
