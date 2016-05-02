class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy, :down_stock, :up_stock, :down_stock_update, :up_stock_update]
  before_action :only_authorize_god!

  def down_stock
    respond_to do |format|
      format.js
    end
  end

  def up_stock
    respond_to do |format|
      format.js
    end
  end


  def down_stock_update
    down_stock = params[:down_stock].to_i
    observation = params[:observation]

    unless down_stock.zero?
      @new_stock_entry = @reward.stock_hard_down({amount: down_stock, owner: @reward, codename: 'arqueo_negativo', observation: observation})
    end

    respond_to do |format|
      flash[:success] = t(:success)
      format.js { render :stock_update }
    end
  end


  def up_stock_update
    up_stock = params[:up_stock].to_i
    observation = params[:observation]

    unless up_stock.zero?
      @new_stock_entry = @reward.stock_hard_up({amount: up_stock, owner: @reward, codename: 'arqueo_positivo', observation: observation})
    end

    respond_to do |format|
      flash[:success] = t(:success)
      format.js { render :stock_update }
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