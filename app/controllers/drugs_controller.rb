class DrugsController < ApplicationController
  
  # GET /drugs/search
  def search
    records = RecordSearcher.call(Drug.all, params)
    render json: records.to_json, callback: params[:callback]
  end
  
end
