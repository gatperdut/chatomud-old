class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def show
    render json: @item
  end

  def index
    render json: Item.all
  end

  def create
    item = Item.new(item_params)

    item.containing_inventory = Inventory.find(item.containing_inventory_id)

    if item.save
      ChatoMud::Controllers::Items::ItemController.new(Server, item, Server.rooms_handler.find(item.containing_inventory.parent.id).inventory_controller)

      rt_not(:item, :created, { id: item.id })

      render json: item
    else
      render json: { errors: item.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      rt_not(:item, :deleted, { id: @item.id })
      head :ok
    else
      render json: { errors: @item.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :short_desc,
      :long_desc,
      :full_desc,
      :slot,
      :containing_inventory_id,
      :item_template_id,
      possible_slots: [],
      kwords: [],
      inventory_attributes: [
        :parent_type,
        lid_attributes: [
          :parent_type,
          lock_attributes: [
            :parent_type
          ]
        ]
      ],
      armor_stat_attributes: [
        :item_id,
        :protection_level,
        :penalty_level,
        :roll_mod,
        :critical_mod,
        :maneuver_impediment,
        :ranged_attack_impediment,
        body_parts: []
      ],
      weapon_stat_attributes: [
        :grip,
        :roll_mod,
        :critical_mod,
        :base,
        melee_stat_attributes: [
          :sheathed_desc
        ],
        ranged_stat_attributes: [
          :missile_type,
          :can_remain_loaded,
          ranges_suitability: [],
          inventory_attributes: [
            :parent_type
          ]
        ]
      ],
      food_attributes: [
        :current,
        :max
      ],
      stack_attributes: [
        :current,
        :max
      ],
      fluid_attributes: [
        :current,
        :max,
        :fluid
      ]
    )
  end
end
