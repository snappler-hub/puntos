# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  text             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  
  # -- Callbacks
  after_create :send_mail_to_gods, if: Proc.new { |c| c.user.is?('admin') } 
  after_create :send_mail_to_admins, if: Proc.new { |c| c.user.is?('god') } 

  # -- Scopes
  default_scope { order(created_at: :desc) }

  # -- Associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # -- Validations
  validates :text, :user, presence: true

  # -- Methods
  def is_owner?(aUser)
    aUser == self.user
  end
  
  def send_mail_to_gods
    title = "Han hecho un comentario"
    message = "Para verlo, haga clic en el siguiente botón e ingrese con su usuario y contraseña. "
    url = "/supplier_requests/#{commentable.id}"
    User.with_role('god').map do |god|
      UserMailer.new_mail(god, title, message, 'Nuevo comentario', url)
    end
  end
  
  def send_mail_to_admins
    title = "Han hecho un comentario"
    message = "Para verlo, haga clic en el siguiente botón e ingrese con su usuario y contraseña. "
    url = "/supplier_requests/#{commentable.id}"
    User.all_from_supplier(commentable.supplier).with_role('admin').map do |admin|
      UserMailer.new_mail(admin, title, message, 'Nuevo comentario', url)
    end
  end

end