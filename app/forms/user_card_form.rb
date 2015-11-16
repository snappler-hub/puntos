class UserCardForm
  include ActiveModel::Model
  include ActiveModel::Serialization

  BASIC_USER_ATTRIBUTES = [
    'first_name', 'last_name', 'document_type',
    'document_number', 'phone', 'email',
    'address', 'supplier_id']

  OTHER_USER_ATTRIBUTES = ['role', 'number', 'username', 'password', 'password_confirmation']
  CARD_ATTRIBUTES = ['card_number']

  ALL_ATTRIBUTES = *BASIC_USER_ATTRIBUTES, *OTHER_USER_ATTRIBUTES, *CARD_ATTRIBUTES

  validates :password, presence: true

  attr_accessor *ALL_ATTRIBUTES

  # El módulo ActiveModel::Serialization pide implementar este método para usar serializable_hash
  def attributes
    ALL_ATTRIBUTES.map{|a| [a, nil]}.to_h
  end

  def self.from_request(request)
    form = UserCardForm.new request.attributes.slice(*BASIC_USER_ATTRIBUTES)
    form.role = 'normal_user'
    form.username = request.full_client_name.parameterize
    form.card_number = Card.count + 1
    return form
  end

  def submit
    if valid?
      user = User.new(serializable_hash.slice(*BASIC_USER_ATTRIBUTES, *OTHER_USER_ATTRIBUTES))
      if user.save
        if user.cards.create(number: card_number)
          user
        else
          # TODO: a medida que agreguemos cosas acá
          self.errors[:card_number] << 'Duplicado'
          false
        end
      else
        user.errors.messages.each do |key, value|
          self.errors[key] << value
        end
        false
      end
    end
  end
end