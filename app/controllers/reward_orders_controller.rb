class RewardOrdersController < ApplicationController
  before_action :set_reward_order, only: [:show, :destroy]


  # GET /rewards
  def index
    @filter = RewardOrderFilter.new(filter_params)
    @reward_orders = @filter.call(current_user).page(params[:page])
    render layout: 'public' if normal_user?
  end

  # GET /rewards/1
  def show
    render layout: 'public' if normal_user?
  end

  def change_state
    @reward_order = RewardOrder.find(params[:id])
    state = params[:state]

    ActiveRecord::Base.transaction do
      @reward_order.change_state(state)
      @reward_order.send_mail
    end

    respond_to do |format|
      format.js
    end
  end

  def voucher_pdf
    @reward_order = RewardOrder.find(params[:id])
    pdf = Pdf::VoucherDocument.new(@reward_order)
    send_data pdf.render, filename: "voucher_#{@reward_order.code}.pdf", type: 'application/pdf'
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
      params.require(:reward_order_filter).permit(:state, :supplier_id, :user_id, :code, :from, :to)
    end
  end
end