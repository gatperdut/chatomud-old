class AreasController < ApplicationController
  before_action :authenticate_player!

  before_action :set_area, only: [
    :show,
    :rooms,
    :update,
    :destroy
  ]

  def index
    render json: Area.all, status: :ok
  end

  def rooms
    render json: @area.rooms
  end

  def show
    render json: @area
  end

  def create
    area = Area.new(area_params)

    if area.save
      ChatoMud::Controllers::Rooms::AreaController.new(Server, area)
      room = area.rooms[0]
      room.anchor(false)
      ChatoMud::Controllers::Rooms::RoomController.new(Server, room)
      Server.rooms_handler.find(room.id).reload_model
      Server.rooms_handler.find(room.id).anchor

      rt_not(:area, :created, { area: area })

      render json: area
    else
      render json: { errors: area.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @area.update(area_params)
      rt_not(:area, :updated, { area: @area })

      render json: @area
    else
      render json: { errors: @area.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @area.destroy
      area_controller = Server.areas_handler.find(@area.id)
      area_controller.bye

      superarea = @area.superarea
      if superarea.areas.count.zero?
        superarea.destroy
        superarea_controller = Server.superareas_handler.find(superarea.id)
        superarea_controller.bye

        rt_not(:superarea, :deleted, { superarea: superarea })
      else
        rt_not(:area, :deleted, { area: @area })
      end

      head :ok
    else
      render json: { errors: @area.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(
      :name,
      :superarea_id,
      rooms_attributes: [
        :title,
        :description,
        :nr_id,
        :er_id,
        :sr_id,
        :wr_id,
        :ur_id,
        :dr_id
      ]
    )
  end
end
