module ChatoMud
  module Mixins
    module Characters
      module Echoes
        module Receiver
          def recv_melee_attack(params)
            @params = params

            text = "\n"

            if @params[:attack].connects
              handle_melee_connecting_attack(text)
            else
              handle_melee_missed_attack(text)
            end

            tx(text)
          end

          private

          def handle_melee_connecting_attack(text)
            text << interpolate_me_other(@params[:assailant], "\nYou strike", "#{@params[:assailant].short_desc} strikes")
            text << interpolate_me_others(@params[:assailant], @params[:target], " #{@params[:target].short_desc} ", " #{you} ", " #{@params[:target].short_desc} ")
            text << strike_adjective
            text << "in #{body_part_description(@params[:body_part])}"
            text << with_your_weapon
          end

          def handle_melee_missed_attack(text)
            text << interpolate_me_other(@params[:assailant], "You miss", "#{@params[:assailant].short_desc} misses")
            text << interpolate_me_others(@params[:assailant], @params[:target], " #{@params[:target].short_desc}", " #{you}", " #{@params[:target].short_desc}")
            text << with_your_weapon
          end

          def strike_adjective
            case @params[:attack].hits
              when -Float::INFINITY..3
                "glancingly "
              when 4..10
                " "
              when 11..17
                "hard "
              when 18..24
                "very hard "
              when 25..32
                "extremely hard "
              when 33..40
                "astonishingly hard "
              when 41..Float::INFINITY
                "brutally "
            end
          end

          def with_your_weapon
            text = " with "

            if @params[:weapon].present?
              text << "#{@params[:weapon].short_desc}."
            else
              text << interpolate_me_other(@params[:assailant], "your", interpolate_possessive(@params[:assailant]))
              text << " fist."
            end
          end
        end
      end
    end
  end
end
