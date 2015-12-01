class RewardOrdersController < ApplicationController
  before_action :set_reward_order, only: [:show, :destroy]


  # GET /rewards
  def index
    @filter = RewardOrderFilter.new(filter_params)
   
    if god?
      @reward_orders = @filter.call.page(params[:page]) 
    else
      @reward_orders = @filter.call(current_user).page(params[:page]) 
    end

    render layout: "public" if normal_user?
  end

  # GET /rewards/1
  def show
  end


  # DELETE /rewards/1
  def destroy
    @reward_order.destroy
    respond_to do |format|
      format.html { redirect_to reward_orders_url, notice: 'El pedido de premios ha sido eliminado correctamente.' }
    end
  end

  private

    def set_reward_order
      @reward_order = RewardOrder.find(params[:id])
    end

    def filter_params
      if params[:reward_order_filter]
        params.require(:reward_order_filter).permit(:state, :supplier_id, :user_id)
      end
    end
end