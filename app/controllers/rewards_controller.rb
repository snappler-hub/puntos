class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_god!, except: [:list, :add_item, :refresh_item, :delete_item, :shoping_cart, :confirm_shoping_cart]  


  def list
    @filter = RewardFilter.new(filter_params)
    @rewards = @filter.call.page(params[:page])
    render layout: "public"
  end



  #-------------------------------------------------- CARRITO
  def add_item
    @reward = Reward.find(params[:id])    
    current_order_item = ShopCart::add(session, @reward.id)
    @source = params[:source]


    respond_to do |format|
      format.js
    end
  end
  #----------------------------------------------------------------


  def refresh_item
    @reward = Reward.find(params[:id])    
    @source = params[:source]

    case params[:act]
    when 'inc'
      current_order_item = ShopCart::inc(session, @reward.id)
    when 'dec'
      current_order_item = ShopCart::dec(session, @reward.id)
    end


    respond_to do |format|
      format.js
    end
  end
  

  #----------------------------------------------------------------


  def delete_item
    @reward = Reward.find(params[:id])    
    ShopCart::sub(session, @reward.id)
    @source = params[:source]


    respond_to do |format|
      format.js
    end
  end



  #----------------------------------------------------------------  
  def shoping_cart
   
    if(current_shop_cart.empty?)
      flash[:notice] = 'Carrito Vacío'
      redirect_to list_rewards_path
    else
      @reward_order = RewardOrder.new(user: current_user)
      render layout: "public"
    end

  end


  #----------------------------------------------------------------  
  def confirm_shoping_cart

    @reward_order = RewardOrder.new(reward_order_params)
    @reward_order.set_shop_cart(current_shop_cart)
    @reward_order.state = 'confirmed'
    if @reward_order.save
      ShopCart::reset(session)
      redirect_to list_rewards_path
    else
      render 'shoping_cart', layout: "public"
    end



  end



   







  # GET /rewards
  def index
    @filter = RewardFilter.new(filter_params)
    @rewards = @filter.call.page(params[:page])
  end

  # GET /rewards/1
  def show
  end

  # GET /rewards/new
  def new
    @reward = Reward.new
  end

  # GET /rewards/1/edit
  def edit
  end

  # POST /rewards
  def create
    @reward = Reward.new(reward_params)

    respond_to do |format|
      if @reward.save
        format.html { redirect_to rewards_path, notice: 'El premio ha sido creado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /rewards/1
  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to rewards_path, notice: 'El premio ha sido actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /rewards/1
  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to rewards_url, notice: 'El premio ha sido eliminado correctamente.' }
    end
  end

  private

    def set_reward
      @reward = Reward.find(params[:id])
    end

    def reward_order_params
      params.require(:reward_order).permit(:user_id, :supplier_id)
    end


    def reward_params
      params['reward']['service_types'] = params['reward']['service_types'] || []
      params['reward']['service_types'] = params['reward']['service_types'].reject(&:blank?)
      params.require(:reward).permit(:name, :description, :code, :need_points, :reward_kind, :image, :remove_image, :service_types => [])
    end

    def filter_params
      if params[:reward_filter]
        params.require(:reward_filter).permit(:name, :code, :need_points, :reward_kind)
      end
    end
end