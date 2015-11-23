class CardManager

  USER_ATTRIBUTES = [
    'first_name', 'last_name', 'document_type',
    'document_number', 'phone', 'email',
    'address', 'supplier_id']

  def self.from_request(request)
    # TODO: Transacción
    user = User.find_or_initialize_by(document_number: request.document_number, document_type: request.document_type)
    user.attributes = request.attributes.slice(*USER_ATTRIBUTES)    
    user.username = request.full_client_name.parameterize
    user.role = 'normal_user'
    user.password = user.password_confirmation = user.email
    user.supplier_request = request
    if user.save
      assign_card_number!(user)
      request.emitted! if request.requested?
    end
    return user
  end

  def self.form_user(user)
    user.assign_card_number!(user)
  end

  def self.accept_terms_of_use!(user)
    user.update(terms_accepted: true)
  end

  def self.assign_card_number!(user)
    user.update(card_number: generate_number(user.id))
  end

  private

  def self.generate_number(id)
    hashids = Hashids.new("this is my salt", 16, "ABCDEF1234567890")
    hashids.encode(id)
  end

end