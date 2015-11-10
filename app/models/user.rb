class User < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'

  validates :supplier, presence: true

  ROLES = ['superadmin', 'admin', 'seller', 'normal_user']
end