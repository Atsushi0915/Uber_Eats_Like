module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create]

      def create
        if LineFood.active.other_restaurant(@orderd_food.restaurant.id)exists?  
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@orderd_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable
        end

        # active  other_restaurant は line_food で設定したscope
        # exists はレコードがデータベースに存在するかを true、false で返す。
        # status: :not_acceptable => HTTPレスポンスステータスコードは406 Not Acceptable

        set_line_food(@orderd_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private
        def set_food
          @orderd_food = Food.find(params[:food_id])
        end

        def set_line_food(orderd_food)
          if orderd_food.line_food.present?
            @line_food = orderd_food.line_food
            @line_food.attributes = {
              count: orderd_food.line_food.count + params[:count],
              active: true
            }
          else
            @line_food = orderd_food.build_line_food(
              count: params[:count],
              restaurant: orderd_food.restaurant,
              active: true
            )
          end
        end
    end
  end
end
