class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_god!, except: [:list]  


  def list
    @filter = RewardFilter.new(filter_params)
    @rewards = @filter.call.page(params[:page])
    render layout: "public"
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