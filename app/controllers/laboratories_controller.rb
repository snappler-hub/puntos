class LaboratoriesController < ApplicationController
  
  # GET /laboratories/search
  def search
    records = RecordSearcher.call(Laboratory.all, params)
    render json: records.to_json, callback: params[:callback]
  end
  
end