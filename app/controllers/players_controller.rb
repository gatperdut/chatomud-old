class PlayersController < ApplicationController
  before_action :authenticate_player!, only: [
    :show,
    :destroy
  ]
  before_action :set_player, only: [
    :show,
    :destroy
  ]

  def show
    render json: @player
  end

  def create
    player = Player.new(player_params)

    if player.save
      render json: player
    else
      render json: { errors: player.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy

    head :no_content
  end

  def authenticate
    player = Player.find_by(username: params[:player][:username])

    if player.blank?
      render json: { error_messages: ["Player does not exist"] }, status: :unauthorized
      return
    end

    if player.authenticate(params[:player][:password])
      render json: player
    else
      render json: { error_messages: ["Password does not match"] }, status: :unauthorized
    end
  end

  private

  def set_player
    @player = current_player
  end

  def player_params
    params.require(:player).permit(
      :username,
      :password,
      :password_confirmation,
      setting_attributes: [
        :ansi_coloring
      ]
    )
  end
end
