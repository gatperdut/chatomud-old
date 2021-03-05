class SuperareasController < ApplicationController
  before_action :authenticate_player!

  before_action :set_superarea, only: [
    :show,
    :rooms,
    :update,
    :destroy
  ]

  def index
    render json: Superarea.all, status: :ok
  end

  def show
    render json: @superarea
  end

  def create
    superarea = Superarea.new(superarea_params)

    if superarea.save
      ChatoMud::Controllers::Rooms::SuperareaController.new(Server, superarea)
      room = superarea.areas[0].rooms[0]
      room.anchor(false)
      ChatoMud::Controllers::Rooms::RoomController.new(Server, room)
      Server.rooms_handler.find(room.id).reload_model
      Server.rooms_handler.find(room.id).anchor

      rt_not(:superarea, :created, { superarea: superarea })

      render json: superarea
    else
      render json: { errors: superarea.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @superarea.update(superarea_params)
      rt_not(:superarea, :updated, { superarea: @superarea })

      render json: @superarea
    else
      render json: { errors: @superarea.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @superarea.destroy
      superarea_controller = Server.superareas_handler.find(@superarea.id)
      superarea_controller.bye

      rt_not(:superarea, :deleted, { superarea: @superarea })

      head :ok
    else
      render json: { errors: @superarea.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_superarea
    @superarea = Superarea.find(params[:id])
  end

  def superarea_params
    params.require(:superarea).permit(
      :name,
      areas_attributes: [
        :name,
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
      ]
    )
  end
end
