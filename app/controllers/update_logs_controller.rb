class UpdateLogsController < ApplicationController
  before_action :set_update_log, only: [:edit, :update, :destroy]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy, :edit]


  # GET /update_logs
  def index
    @update_logs = UpdateLog.all
  end


  # GET /update_logs/1
  def show
    @reporte = YAML.load(set_update_log.description)
  end


  # DELETE /update_logs/1
  def destroy
    @update_log.destroy
    respond_to do |format|
      format.html { redirect_to update_logs_url, notice: 'El producto ha sido eliminado correctamente.' }
    end
  end


  private

  def set_update_log
    @update_log = UpdateLog.find(params[:id])
  end

end
