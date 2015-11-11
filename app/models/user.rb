class User < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'

  validates :supplier, presence: true
  validates :password, confirmation: true

  ROLES = ['god', 'admin', 'seller', 'normal_user']

  def is?(a_role)
    role == a_role.to_s
  end

  def to_param
    "#{id}-#{first_name}-#{last_name}".parameterize
  end

end