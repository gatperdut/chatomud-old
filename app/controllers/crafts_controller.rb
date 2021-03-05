class CraftsController < ApplicationController
  before_action :authenticate_player!

  before_action :set_craft, only: [
    :show,
    :update,
    :destroy
  ]

  def show
    render json: @craft, include: [
      :craft_ingredients,
      craft_steps: [
        :craft_test,
        :craft_item_results
      ]
    ]
  end

  def index
    render json: Craft.all, status: :ok, include: [
      :craft_ingredients,
      craft_steps: [
        :craft_test,
        :craft_item_results
      ]
    ]
  end

  def create
    craft = Craft.new(craft_params)

    if craft.save
      rt_not(:craft, :created, { id: craft.id })

      render json: craft
    else
      render json: { errors: craft.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @craft.update(craft_params)
      rt_not(:craft, :updated, { id: @craft.id })

      render json: @craft
    else
      render json: { errors: @craft.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @craft.destroy
      rt_not(:craft, :deleted, { id: @craft.id })
      head :ok
    else
      render json: { errors: @craft.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_craft
    @craft = Craft.find(params[:id])
  end

  def craft_params
    params.require(:craft).permit(
      :category,
      :name,
      craft_ingredients_attributes: [
        :id,
        :location,
        :how_many,
        :usage_type,
        "_destroy",
        item_template_codes: []
      ],
      craft_steps_attributes: [
        :id,
        :echo_first,
        :echo_third,
        :fail_first,
        :fail_third,
        :delay,
        "_destroy",
        craft_test_attributes: [
          :id,
          :skill,
          :modifier
        ],
        craft_item_results_attributes: [
          :id,
          :item_template_code,
          :skill,
          :how_many,
          "_destroy"
        ]
      ]
    )
  end
end
