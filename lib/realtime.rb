module Realtime
  # For more realtime methods just append the method name to the array
  # it will automatically send the method name as action redis param
  # which in turn maps to a javascript function

  ACTIONS = %w[
    superarea
    area
    room
    door

    item_template
    item
    craft
  ].freeze

  ACTIONS.each do |action|
    define_singleton_method(action) do |channel, params|
      if REDIS.pubsub("channels").include?(channel)
        Rails.logger.info(params.to_json)
        params[:action] = action
        REDIS.publish(channel, params.to_json)
      end
    end
  end
end
