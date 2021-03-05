require "mixins/characters/physical_attrs/genders/utils"
require "mixins/slots/utils"
require "mixins/periodic/calendar/utils"
require "mixins/body_parts/utils"
require "mixins/directions/utils"

module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          include PhysicalAttrs::Genders::Utils
          include Slots::Utils
          include Periodic::Calendar::Utils
          include Mixins::BodyParts::Utils
          include Mixins::Directions::Utils

          def interpolate_possessive(character_controller)
            self == character_controller ? possessive(:personal) : possessive(character_controller.physical_attr_controller.gender)
          end

          def interpolate_me_other(character_controller, for_me, for_others)
            self == character_controller ? for_me : for_others
          end

          def interpolate_me_others(first_character_controller, second_character_controller, for_first, for_second, for_others)
            return for_first  if self == first_character_controller
            return for_second if self == second_character_controller

            for_others
          end

          def you
            "you".magenta
          end

          def guess_spoken_language(speaker_controller)
            comms_controller.guess_spoken_language(speaker_controller)
          end

          def garble_speech(speech, speaker_controller)
            return speech if self == speaker_controller

            language = speaker_controller.choice_controller.language

            speaker_skill_mod = speaker_controller.stats_controller.skill_modifier(language)

            "#{comms_controller.understand_oral(speech.to_s, language, speaker_skill_mod)}"
          end

          def can_see_action?(emitter)
            return false if entity_controller.is_editing?

            self == emitter || room_controller.can_be_seen_by_character?(self)
          end

          def interpolate_refs(emote, emitter, prepend_at)
            text = ""

            at_found = false

            quoted_speech_found = false

            emote.each do |emote_part|
              case emote_part.keys[0]
                when :emote_text
                  text << emote_part[:emote_text]
                when :spaces
                  text << emote_part[:spaces]
                when :at
                  text << emitter.short_desc
                  at_found = true
                when :speech
                  text << "\"#{garble_speech(emote_part[:speech], emitter)}\""
                when :quoted_speech
                  text << "\"#{garble_speech(emote_part[:quoted_speech], emitter).to_s.cyan}\""
                  quoted_speech_found = true
                when :ref
                  kword = emote_part[:ref]
                  ref_type = kword[:type]
                  target   = kword[:target]
                  case ref_type
                    when "*"
                      item_controller = emitter.search_item_controller(target, :anywhere)
                      unless item_controller
                        emitter.tx("You cannot find that '#{target[:word]}'.") if self == emitter
                        return nil
                      end
                      text << item_controller.short_desc
                    when "~"
                      character_controller = emitter.search_character_controller(target)
                      unless character_controller
                        emitter.tx("You cannot find '#{target[:word]}'.") if self == emitter
                        return nil
                      end
                      text << interpolate_me_other(character_controller, you, character_controller.short_desc)
                  end
              end
            end

            text.prepend("#{emitter.short_desc} ") if prepend_at && !at_found

            text << " (#{guess_spoken_language(emitter)})" if quoted_speech_found

            text
          end
        end
      end
    end
  end
end
