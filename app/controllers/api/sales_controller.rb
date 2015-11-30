class Api::SaleController < Api::MainController

  def authorize
    adapter = AuthorizationiAdapter.new(query)
    if adapter.valid_input?
      manager = AuthorizationFromSale.new(adapter.sale, adapter.seller)
      authorization = manager.authorize!
      render json: {status: :ok}, status: :ok
    else
      render json: adapter.errors, status: 400
    end
  end

  def confirm
    authorization =  Authorization.find(query[:authorization_id])
    manager = SaleFromAuthorization.new(authorization)
    if manager
      manager.create
      render json: {status: :ok}, status: :ok
    else
      render json: manager.errors, status: 400
    end
  end

end