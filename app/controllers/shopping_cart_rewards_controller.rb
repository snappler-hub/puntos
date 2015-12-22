class ShoppingCartRewardsController < ApplicationController

  def list
    @filter = RewardFilter.new(filter_params)
    @rewards = @filter.call.page(params[:page])

    render layout: 'public' if normal_user?
  end

  #-------------------------------------------------- CARRITO

  def add_item
    @reward = Reward.find(params[:id])

    if (ShopCart::need_points(session) + @reward.need_points) > current_user.cache_points
      raise(RequestExceptions::BadRequestError.new('No se dispone de puntos para efectuar la operación'))
    end

    ShopCart::add(session, @reward.id, @reward.need_points)
    @source = params[:source]

    respond_to do |format|
      format.js
    end
  end

  #----------------------------------------------------------------

  def refresh_item
    @reward = Reward.find(params[:id])
    @source = params[:source]
    @operation = params[:act]

    case @operation
      when 'inc'
        ShopCart::inc(session, @reward.id)
      when 'dec'
        ShopCart::dec(session, @reward.id)
    end

    respond_to do |format|
      format.js
    end
  end

  #----------------------------------------------------------------

  def delete_item
    @reward = Reward.find(params[:id])
    @item = ShopCart::find(session, @reward.id)
    ShopCart::sub(session, @reward.id)
    @source = params[:source]

    respond_to do |format|
      format.js
    end
  end

  #----------------------------------------------------------------

  def shoping_cart
    @user_supplier = current_user.supplier

    if current_shop_cart.empty?
      flash[:notice] = 'Carrito Vacío'
      redirect_to list_shopping_cart_rewards_path
    else
      @reward_order = RewardOrder.new(user: current_user)
      render layout: 'public' if normal_user?
    end
  end

  #----------------------------------------------------------------

  def confirm_shoping_cart

    @reward_order = RewardOrder.new(reward_order_params)
    @reward_order.set_shop_cart(current_shop_cart)

    if @reward_order.save
      @reward_order.change_state('requested')
      ShopCart::reset(session)
      redirect_to reward_orders_path
    else
      if normal_user?
        render 'shoping_cart', layout: 'public'
      else
        render 'shoping_cart'
      end
    end
  end

  private

  def reward_order_params
    params.require(:reward_order).permit(:user_id, :supplier_id)
  end

  def filter_params
    if params[:reward_filter]
      params.require(:reward_filter).permit(:name, :code, :need_points, :reward_kind)
    end
  end

end