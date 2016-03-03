class Pathology < ActiveRecord::Base

  # -- Associations
  has_and_belongs_to_many :supplier_requests

  # -- Scopes
  default_scope { order(:name) }

end
