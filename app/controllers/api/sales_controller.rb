class Api::SalesController < Api::MainController

  def authorize
    adapter = AuthorizationAdapter.new(query)
    if adapter.valid_input?
      manager = AuthorizationFromSale.new(adapter.sale, adapter.seller, adapter.response)
      authorization = manager.authorize!
      render json: {status: :ok, authorization: authorization}, status: :ok
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