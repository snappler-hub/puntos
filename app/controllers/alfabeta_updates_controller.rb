class AlfabetaUpdatesController < ApplicationController
  # before_action :set_product, only: [:edit, :update, :destroy]
  # before_action :only_authorize_god!, only: [:index, :new, :create, :destroy, :edit]


  # GET /alfabeta_updates
  def index
    @filter = AlfabetaUpdateFilter.new(filter_params)
    @alfabeta_updates = @filter.call.page(params[:page])
  end


  # GET /alfabeta_updates/show/:id
  def show
    @alfabeta_update = AlfabetaUpdate.find(params[:id])
    @reporte = YAML.load(@alfabeta_update.description)
  end


  def filter_params
    if params[:alfabeta_update_filter]
      params.require(:alfabeta_update_filter).permit(:start_date, :finish_date)
    end
  end

end
