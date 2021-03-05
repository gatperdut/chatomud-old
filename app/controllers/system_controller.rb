class SystemController < ApplicationController
  def info
    render json: {
      ruby_version: RUBY_VERSION,
      rails_version: Rails.version,
      git_revision: `git rev-parse HEAD`.strip,

      redis_channel: APP_CONFIG["redis_channel"],
      socket_io_uri: APP_CONFIG["socket_io_uri"],

      time_string: Server.timer.calendar.time_string
    }
  end
end
