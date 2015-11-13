class Api::CardsController < Api::MainController

  def create
    loader = CardLoader.new(query)
    if loader.valid_input?
      # Crear tarjetas
      # TODO: loader.call
      render json: {status: :ok}, status: :ok
    else
      render json: loader.errors, status: 400
    end
  end

end