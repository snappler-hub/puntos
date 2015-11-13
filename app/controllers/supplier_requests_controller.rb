class SupplierRequestsController < ApplicationController
  before_action :set_supplier
  before_action :set_supplier_request, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_admin!, except: [:show, :edit, :update, :destroy]

  # GET /supplier_requests
  # GET /supplier_requests.json
  def index
    @filter = SupplierRequestFilter.new(filter_params)
    @supplier_requests = @filter.call(@supplier).page(params[:page])
  end
  
  # GET /supplier_requests/1
  # GET /supplier_requests/1.json
  def show
  end
  
  # GET /supplier_requests/new
  def new
    @supplier_request = SupplierRequest.new
  end
  
  # POST /supplier_requests
  # POST /supplier_requests.json
  def create
    @supplier_request = SupplierRequest.new(supplier_request_params)
    @supplier_request.supplier = @supplier if @supplier
    @supplier_request.created_by = current_user if current_user

    respond_to do |format|
      if @supplier_request.save
        format.html { redirect_to [@supplier, @supplier_request], notice: 'La solicitud ha sido creada correctamente.' }
        format.json { render :show, status: :created, location: @supplier_request }
      else
        format.html { render :new }
        format.json { render json: @supplier_request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /supplier_requests/1/edit
  def edit
  end

  # PATCH/PUT /supplier_requests/1
  # PATCH/PUT /supplier_requests/1.json
  def update    
    respond_to do |format|
      if @supplier_request.update(supplier_request_params)
        format.html { redirect_to [@supplier, @supplier_request], notice: 'La solicitud ha sido actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @supplier_request }
      else
        format.html { render :edit }
        format.json { render json: @supplier_request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /supplier_requests/1
  # DELETE /supplier_requests/1.json
  def destroy
    @supplier_request.destroy
    respond_to do |format|
      format.html { redirect_to [@supplier, :supplier_requests], notice: 'La solicitud ha sido eliminada correctamente.' }
      format.json { head :no_content }
    end
  end
  
  private
  
  def set_supplier
    if params[:supplier_id]
      @supplier = Supplier.find(params[:supplier_id])
    end
  end
  
  def set_supplier_request
    if @supplier
      @supplier_request = @supplier.supplier_requests.find(params[:id])
    else
      @supplier_request = SupplierRequest.find(params[:id])
    end
  end
  
  def filter_params
    if params[:supplier_request_filter]
      allow_params = [:status, :name, :document_number]
      allow_params << :supplier_id if god?
      
      parameters = params.require(:supplier_request_filter).permit(allow_params) 
    end
  end
  
  def supplier_request_params
    allow_params = [:first_name, :last_name, :document_type, :document_number, :phone, :email, :address, :notes]
    allow_params << :supplier_id << :status if god?
    
    parameters = params.require(:supplier_request).permit(allow_params)
    
  end
  
end
