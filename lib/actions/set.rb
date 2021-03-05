module ChatoMud
  module Actions
    class Set < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        text = "stance:\n".cyan
        text << "  pacifist\n"
        text << "  defensive\n"
        text << "  careful\n"
        text << "  normal\n"
        text << "  aggressive\n"
        text << "  frantic\n"
        text << "  frenzy\n"

        text << "editor_echoes:\n".cyan
        text << "  on\n"
        text << "  off\n"

        text << "pace:\n".cyan
        text << "  crawl\n"
        text << "  trudge\n"
        text << "  walk\n"
        text << "  jog\n"
        text << "  sprint\n"
        text << "  dash\n"

        text << "e.g.: set stance aggressive\n"

        tx(text)
      end
    end
  end
end
