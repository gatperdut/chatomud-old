class ApplicationController < ActionController::API
  attr_reader :current_player

  def authenticate_player!
    id     = request.headers["X-PLAYER-ID"]
    token  = request.headers["X-PLAYER-AUTHENTICATION-TOKEN"]
    player = Player.find_by_id(id)

    if player && Devise.secure_compare(player.authentication_token, token)
      @current_player = player
    else
      throw("wrong authentication token")
    end
  end

  def rt_not(action, subaction, payload)
    Realtime.send(action, APP_CONFIG["redis_channel"], { subaction: subaction }.merge(payload))
  end
end
