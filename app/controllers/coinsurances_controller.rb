class CoinsurancesController < ApplicationController
  
  # GET /coinsurance/search
  def search
    records = RecordSearcher.call(Coinsurance.all, params)
    render json: records.to_json, callback: params[:callback]
  end
  
end
