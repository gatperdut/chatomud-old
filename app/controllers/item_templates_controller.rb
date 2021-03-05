class ItemTemplatesController < ApplicationController
  before_action :authenticate_player!

  before_action :set_item_template, only: [
    :show,
    :update,
    :destroy
  ]

  def show
    render json: @item_template, include: [
      :food,
      :fluid,
      :stack,
      :armor_stat_template,
      :shield_stat_template,
      :light_source_template,
      weapon_stat_template: [
        :melee_stat_template,
        ranged_stat_template: [
          :inventory_template
        ]
      ],
      inventory_template: [
        lid_template: [
          lock_template
        ]
      ]
    ]
  end

  def show_by_code
    item_template = ItemTemplate.find_by_code(params[:code])
    render json: item_template, include: [
      :food,
      :fluid,
      :stack,
      :armor_stat_template,
      :shield_stat_template,
      :light_source_template,
      weapon_stat_template: [
        :melee_stat_template,
        ranged_stat_template: [
          :inventory_template
        ]
      ],
      inventory_template: [
        lid_template: [
          :lock_template
        ]
      ]
    ]
  end

  def index
    render json: ItemTemplate.all, status: :ok, include: [
      :food,
      :fluid,
      :stack,
      :armor_stat_template,
      :light_source_template,
      weapon_stat_template: [
        :melee_stat_template,
        ranged_stat_template: [
          :inventory_template
        ]
      ],
      inventory_template: [
        lid_template: [
          :lock_template
        ]
      ]
    ]
  end

  def search
    term = params[:term]

    render json: ItemTemplate.where("code LIKE ?", "%#{term}%").or(ItemTemplate.where("short_desc LIKE ?", "%#{term}%"))
  end

  def create
    item_template = ItemTemplate.new(item_template_params)

    if item_template.save
      rt_not(:item_template, :created, { id: item_template.id })

      render json: item_template
    else
      render json: { errors: item_template.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @item_template.update(item_template_params)
      rt_not(:item_template, :updated, { id: @item_template.id })

      render json: @item_template
    else
      render json: { errors: @item_template.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @item_template.destroy
      rt_not(:item_template, :deleted, { item_template: @item_template })
      head :ok
    else
      render json: { errors: @item_template.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_item_template
    @item_template = ItemTemplate.find(params[:id])
  end

  def item_template_params
    params.require(:item_template).permit(
      :short_desc,
      :long_desc,
      :full_desc,
      kwords: [],
      possible_slots: [],
      inventory_template_attributes: [
        :parent_type,
        lid_template_attributes: [
          :parent_type,
          lock_template_attributes: [
            :parent_type
          ]
        ]
      ],
      armor_stat_template_attributes: [
        :protection_level,
        :penalty_level,
        :roll_mod,
        :critical_mod,
        :maneuver_impediment,
        :ranged_attack_impediment,
        body_parts: []
      ],
      shield_stat_template_attributes: [
        # TODO
      ],
      light_source_template_attributes: [
        # TODO
      ],
      weapon_stat_template_attributes: [
        :grip,
        :base,
        melee_stat_template_attributes: [
          :sheathed_desc
        ],
        ranged_stat_template_attributes: [
          :missile_type,
          :can_remain_loaded,
          ranges_suitability: [],
          inventory_template_attributes: [
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
