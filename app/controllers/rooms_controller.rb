require "mixins/directions/utils"

class RoomsController < ApplicationController
  include ChatoMud::Mixins::Directions::Utils

  before_action :authenticate_player!

  before_action :set_room, only: [
    :show,
    :update,
    :destroy
  ]

  def index
    render json: Room.all, status: :ok
  end

  def search
    term = params[:term]

    render json: Room.where(id: term).or(Room.where("title LIKE ?", "%#{term}%"))
  end

  def show
    render json: @room
  end

  def create
    room = Room.new(room_params)

    if room.save
      room.anchor(false)
      ChatoMud::Controllers::Rooms::RoomController.new(Server, room)
      Server.rooms_handler.find(room.id).reload_model
      Server.rooms_handler.find(room.id).anchor

      rt_not(:room, :created, { room: room })

      render json: room
    else
      render json: { errors: room.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      @room.anchor(false)
      Server.rooms_handler.find(@room.id).reload_model
      Server.rooms_handler.find(@room.id).anchor

      rt_not(:room, :updated, { room: @room })

      render json: @room
    else
      render json: { errors: @room.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy

      room_controller = Server.rooms_handler.find(@room.id)
      room_controller.bye
      room_controller.anchor

      area = @room.area
      superarea = area.superarea
      if area.rooms.count.zero?
        area.destroy
        area_controller = Server.areas_handler.find(area.id)
        area_controller.bye

        if superarea.areas.count.zero?
          superarea.destroy
          superarea_controller = Server.superareas_handler.find(superarea.id)
          superarea_controller.bye

          rt_not(:superarea, :deleted, { superarea: superarea })
        else
          rt_not(:area, :deleted, { area: area })
        end
      else
        rt_not(:room, :deleted, { room: @room })
      end

      head :ok
    else
      render json: { errors: @room.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(
      :title,
      :description,
      :area_id,
      :nr_id,
      :er_id,
      :sr_id,
      :wr_id,
      :ur_id,
      :dr_id
    )
  end
end
