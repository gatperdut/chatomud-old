require "mixins/characters/comms/guesser"

module ChatoMud
  module Controllers
    module Characters
      class CommsController
        include Mixins::Characters::Comms::Guesser

        def initialize(server, character_controller)
          @server = server
          @character_controller = character_controller
        end

        def understand_oral(speech, language, speaker_language_skill_mod)
          miss_rate_listener = word_miss_rate(skill_mod(language))

          miss_rate_speaker  = word_miss_rate(speaker_language_skill_mod)

          miss_rates = [
            miss_rate_listener,
            miss_rate_speaker
          ]

          miss_rate = miss_rates.min

          bonus = miss_rate.zero? ? 0 : good_command_bonus(miss_rates)

          garble(speech, miss_rate, bonus)
        end

        def understand_written(text, text_info)
          miss_rate_reader_language = word_miss_rate(skill_mod(text_info.language))
          miss_rate_reader_script   = word_miss_rate(skill_mod(text_info.script))

          miss_rate_writer_language = word_miss_rate(text_info.language_skill_mod)
          miss_rate_writer_script   = word_miss_rate(text_info.script_skill_mod)

          miss_rates_language = [
            miss_rate_reader_language,
            miss_rate_writer_language
          ]

          bonus_language = good_command_bonus(miss_rates_language)

          miss_rate_language = miss_rates_language.min

          miss_rates_script = [
            miss_rate_reader_script,
            miss_rate_writer_script
          ]

          bonus_script = good_command_bonus(miss_rates_script)

          miss_rate_script = miss_rates_script.min

          miss_rates = [
            miss_rate_language,
            miss_rate_script
          ]

          miss_rate = miss_rates.min

          total_bonus = miss_rate.zero? ? 0 : bonus_language + bonus_script

          garble(text, miss_rate, total_bonus)
        end

        private

        def word_miss_rate(skill_modifier)
          case skill_modifier
            when -Float::INFINITY..9
              0
            when 10..19
              3
            when 20..29
              4
            when 30..39
              5
            when 40..49
              6
            when 50..Float::INFINITY
              Float::INFINITY
          end
        end

        def good_command_bonus(miss_rates)
          miss_rates.any? { |miss_rate| is_infinity?(miss_rate) } ? 1 : 0
        end

        def is_infinity?(miss_rate)
          miss_rate.infinite? == 1 # Why doesn't it return true?!
        end

        def garble(text, miss_rate, bonus)
          return text if is_infinity?(miss_rate)

          return garble_all(text) if miss_rate.zero?

          garble_partial(text, miss_rate + bonus)
        end

        def garble_all(text)
          text.gsub(/\w+/) { |word| "." * word.length }
        end

        def garble_partial(text, miss_rate)
          text.gsub(/\w+/).with_index { |word, index| (index % miss_rate).zero? ? "." * word.length : word }
        end

        def skill_mod(skill)
          @character_controller.stats_controller.skill_modifier(skill)
        end
      end
    end
  end
end
