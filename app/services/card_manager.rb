class CardManager

  USER_ATTRIBUTES = [
    'first_name', 'last_name', 'document_type',
    'document_number', 'phone', 'email',
    'address', 'supplier_id']

  def self.from_request(request)
    user = User.find_or_initialize_by(document_number: request.document_number, document_type: request.document_type)
    user.attributes = request.attributes.slice(*USER_ATTRIBUTES)    
    user.username = request.full_client_name.parameterize
    user.role = 'normal_user'
    user.password = user.password_confirmation = user.email
    user.cards.build(number: next_card_number, supplier_request: request)
    if user.save
      request.emitted! if request.requested?
    end
    return user
  end

  private

  def self.next_card_number
    Card.count + 1
  end

end