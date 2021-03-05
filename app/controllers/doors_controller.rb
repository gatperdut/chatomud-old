class DoorsController < ApplicationController
  before_action :authenticate_player!

  before_action :set_door, only: [
    :show,
    :update,
    :destroy
  ]

  def index
    render json: Door.all, status: :ok
  end

  def show
    render json: @door
  end

  def create
    door = Door.new(door_params)

    if door.save
      door.anchor(false)
      ChatoMud::Controllers::Rooms::DoorController.new(Server, door)
      Server.doors_handler.find(door.id).reload_model
      Server.doors_handler.find(door.id).anchor

      rt_not(:door, :created, { door: door })

      render json: door
    else
      render json: { errors: door.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @door.update(door_params)
      Server.doors_handler.find(@door.id).reload_model

      rt_not(:door, :updated, { door: @door })

      render json: @door
    else
      render json: { errors: @door.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @door.anchor(true)

    @door.destroy

    door_controller = Server.doors_handler.find(@door.id)
    door_controller.bye
    door_controller.anchor

    rt_not(:door, :deleted, { door: @door })
  end

  private

  def set_door
    @door = Door.find(params[:id])
  end

  def door_params
    params.require(:door).permit(
      :short_desc,
      :long_desc,
      :full_desc,
      :nr_id,
      :er_id,
      :sr_id,
      :wr_id,
      :ur_id,
      :dr_id,
      :see_through
    )
  end
end
