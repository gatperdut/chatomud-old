module ChatoMud
  module Actions
    class SetEditorEchoes < BaseAction
      def exec
        return unless can_perform?([:unconscious])

        editor_echoes = @params[:editor_echoes].to_sym

        return unless check_is_valid_editor_echoes(editor_echoes, "'#{editor_echoes}' is not a valid option - use either 'on' or 'off'.")

        editor_echoes = editor_echoes == :on

        if @character_controller.choice_controller.editor_echoes_is?(editor_echoes)
          tx("You are already in that mode for the editor echoes.")
          return
        end

        @character_controller.choice_controller.editor_echoes!(editor_echoes)

        tx("You #{@character_controller.choice_controller.editor_echoes_colorized} receive echoes of your input during editing from now on.")
      end
    end
  end
end
