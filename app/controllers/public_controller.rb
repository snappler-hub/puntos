class PublicController < ApplicationController

  def home
    should_have_a_card_assigned!
    should_accept_terms_of_use!
  end

  def no_cards_assigned
    if no_cards_assigned?
      render layout: "sessions"
    else
      redirect_to current_user_path, alert: 'No pudo realizar la acción.'
    end
  end

  def terms_of_use
    should_have_a_card_assigned!
    if should_accept_terms_of_use?
      render layout: "sessions"
    end
  end

  def accept_terms_of_use
    should_have_a_card_assigned!
    if should_accept_terms_of_use?
      CardManager.accept_terms_of_use!(current_user)
      redirect_to current_user_path, notice: 'Has aceptado los términos de uso de la tarjeta.'
    else
      redirect_to current_user_path, alert: 'No tiene tarjeta o no debe aceptar términos de uso'
    end
  end

  private

  def should_accept_terms_of_use!
    if should_accept_terms_of_use?
      redirect_to terms_of_use_path
    end
  end

  def should_have_a_card_assigned!
    redirect_to no_cards_assigned_path if no_cards_assigned?
  end

  def no_cards_assigned?
    !current_user.card_number
  end

  def should_accept_terms_of_use?
    current_user.card_number && !current_user.terms_accepted?
  end
  helper_method :should_accept_terms_of_use?

end