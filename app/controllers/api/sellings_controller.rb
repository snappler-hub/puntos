class Api::SellingsController < Api::MainController

  def update
    manager = SellingManager.new(query)
    if manager.valid_input?
      # Impactar ventas
      # TODO: manager.update
      render json: {status: :ok}, status: :ok
    else
      render json: manager.errors, status: 400
    end
  end

  def authorize
    manager = SellingManager.new(query)
    if manager.valid_input?
      # Autorizar ventas
      # TODO: manager.authorize
      render json: {status: :ok}, status: :ok
    else
      render json: manager.errors, status: 400
    end
  end

end