class Api::SaleController < Api::MainController

  def update
    adapter = SaleApiAdapter.new(query)
    if adapter.valid_input?
      manager = SaleManager.new(adapter.sale, adapter.seller)
      # Impactar ventas
      # TODO: manager.update
      render json: {status: :ok}, status: :ok
    else
      render json: manager.errors, status: 400
    end
  end

  def authorize
    manager = SaleManager.new(query)
    if manager.valid_input?
      # Autorizar ventas
      # TODO: manager.authorize
      render json: {status: :ok}, status: :ok
    else
      render json: manager.errors, status: 400
    end
  end

end