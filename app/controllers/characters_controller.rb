class CharactersController < ApplicationController
  before_action :authenticate_player!

  before_action :set_character, only: [
    :show,
    :update
  ]

  def show
    render json: @character
  end

  def create
    character = Character.new(character_params)

    character.room_id = Room.first.id

    if character.save
      render json: character
    else
      render json: { errors: character.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)

      character_controller = Server.characters_handler.find(@character.id)
      character_controller.reload_model if character_controller.present?

      render json: @character
    else
      render json: { errors: @character.errors.messages }, status: :unprocessable_entity
    end
  end

  def yours
    render json: current_player.current_character, include: [:attribute_set, :skill_set]
  end

  def previous
    characters = current_player.characters.reject(&:active)

    render json: characters
  end

  private

  def set_character
    @character = Character.find(params[:character][:id])
  end

  def character_params
    params.require(:character).permit(
      :name,
      :short_desc,
      :long_desc,
      :full_desc,
      :active,
      :player_id,
      kwords: [],
      attribute_set_attributes: [
        :id,
        :str,
        :dex,
        :con,
        :int,
        :wil,
        :agi,
        :pow
      ],
      skill_set_attributes: [
        :id,
        :melee,
        :ranged,
        :martial,
        :athletics,
        :forging,
        :light_edge,
        :medium_edge,
        :heavy_edge,
        :medium_blunt,
        :heavy_blunt,
        :light_pierce,
        :medium_pierce,
        :polearm,
        :archery,
        :crossbow,
        :armor_use,
        :block,
        :parry,
        :dual_wield,
        :throwing,
        :body_development,
        :dodge,
        :brawl,
        :metalworking
      ]
    )
  end
end
