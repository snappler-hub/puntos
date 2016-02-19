class HealthInsurancesController < ApplicationController
  
  # GET /health_insurance/search
  def search
    records = RecordSearcher.call(HealthInsurance.all, params)
    render json: records.to_json, callback: params[:callback]
  end
  
end
