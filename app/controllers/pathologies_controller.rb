class PathologiesController < ApplicationController
  before_action :set_pathology, only: [:edit, :update, :destroy]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy]

  # GET /pathologies
  def index
    @pathologies = Pathology.all
  end

  # GET /pathologies/new
  def new
    @pathology = Pathology.new
  end

  # GET /pathologies/1/edit
  def edit
  end

  # POST /pathologies
  def create
    @pathology = Pathology.new(pathology_params)
    respond_to do |format|
      if @pathology.save
        format.html { redirect_to pathologies_path, notice: 'La Patología ha sido creada correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /pathologies/1
  def update
    respond_to do |format|
      if @pathology.update(pathology_params)
        format.html { redirect_to pathologies_path, notice: 'La Patología ha sido actualizada correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /pathologies/1
  def destroy
    @pathology.destroy
    respond_to do |format|
      format.html { redirect_to pathologies_url, notice: 'La Patologia ha sido eliminada correctamente.' }
    end
  end

  private

  def set_pathology
    @pathology = Pathology.find(params[:id])
  end

  def pathology_params
    params.require(:pathology).permit(:name)
  end

end
