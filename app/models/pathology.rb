# == Schema Information
#
# Table name: pathologies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pathology < ActiveRecord::Base

  # -- Associations
  has_and_belongs_to_many :supplier_requests

  # -- Scopes
  default_scope { order(:name) }

end
