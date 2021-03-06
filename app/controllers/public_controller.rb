class PublicController < ApplicationController
  layout :define_layout
  skip_before_filter :should_accept_terms_of_use!

  def home
    should_have_a_card_assigned!
    should_accept_terms_of_use!

    #Todos los productos de los pfpcs activos
    periods = PfpcService.where(user: current_user).in_progress.collect { |pfpc| pfpc.last_period }
    @period_products = []
    periods.map do |p|
      p.period_products.map do |pp|
        @period_products << pp
      end
    end
  end

  def no_cards_assigned
    if no_cards_assigned?
      render layout: 'sessions'
    else
      redirect_to current_user_path, alert: 'No pudo realizar la acción.'
    end
  end

  def terms_of_use
    should_have_a_card_assigned!
    if should_accept_terms_of_use?
      render layout: 'sessions'
    end
  end

  def accept_terms_of_use
    should_have_a_card_assigned!
    if should_accept_terms_of_use?
      current_user.accept_terms_of_use
      redirect_to current_user_path, notice: 'Has aceptado los términos de uso de la tarjeta.'
    else
      redirect_to current_user_path, alert: 'No tiene tarjeta o no debe aceptar términos de uso'
    end
  end

  private

  def should_have_a_card_assigned!
    redirect_to no_cards_assigned_path if no_cards_assigned?
  end

  def no_cards_assigned?
    !current_user.card_number
  end

  def define_layout
    unless normal_user?
      'application'
    else
      'public'
    end
  end

end