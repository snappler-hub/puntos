class UserFilter
  include ActiveModel::Model
  attr_accessor :email, :role, :card_number, :document_number, :card_state, :supplier_id

  def call(current_user = nil)


    # users = context ? context.users : User.all.includes(:supplier)
    if current_user
      case current_user.role
        when 'god'
          users = User.all.includes(:supplier)
        when 'admin'
          users = User.where(supplier_id: current_user.supplier_id).includes(:supplier)
        else
          users = User.find(current_user.id).includes(:supplier)
      end
    end

    users = users.where(supplier_id: @supplier_id) if @supplier_id.present?
    users = users.where('email LIKE ?', "%#{@email}%") if @email.present?
    users = users.where('document_number LIKE ?', "%#{@document_number}%") if @document_number.present?
    users = users.where('card_number LIKE ?', "%#{@card_number}%") if @card_number.present?
    users = users.where(role: @role) if @role.present?

    case @card_state
      when 'without_card'
        users = users.where(card_number: nil)
      when 'should_accept_terms'
        users = users.where(terms_accepted: false).where.not(card_number: nil)
      when 'with_card'
        users = users.where(terms_accepted: true).where.not(card_number: nil)
    end

    users
  end
end