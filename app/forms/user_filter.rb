class UserFilter
  include ActiveModel::Model
  attr_accessor :email, :role

  def call(context = false)
    users = context ? context.users : User.all.includes(:supplier)
    users = users.where('email LIKE ?', "%#{@email}%") if @email.present?
    users = users.where(role: @role) if @role.present?
    users
  end
end