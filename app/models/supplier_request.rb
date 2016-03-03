# == Schema Information
#
# Table name: supplier_requests
#
#  id              :integer          not null, primary key
#  supplier_id     :integer
#  user_id         :integer
#  created_by_id   :integer
#  resolution_date :datetime
#  status          :integer          default(0)
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  document_type   :string(255)      not null
#  document_number :string(255)      not null
#  phone           :string(255)
#  email           :string(255)
#  address         :string(255)
#  notes           :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SupplierRequest < ActiveRecord::Base
  
  include Destroyable

  # -- Scopes
  default_scope { order(created_at: :desc) }

  # -- Associations
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :comments, as: :commentable
  belongs_to :user
  has_and_belongs_to_many :pathologies

  # -- Validations
  validates :first_name, :last_name, :document_type, :document_number, :supplier, :created_by, presence: true

  # -- Misc
  enum status: {requested: 0, rejected: 1, in_progress: 2, emitted: 3, pre_delivered: 4, delivered: 5}

  # -- Methods

  # Returns client last_name and first_name
  def full_client_name
    "#{last_name}, #{first_name}"
  end

  # Returns identification type and number
  def full_identification
    "#{document_type} #{document_number}"
  end

  def can_be_viewed_by?(user)
    (user.is? :god) || (user.is?(:admin) && (user.supplier == self.supplier))
  end
  
  def destroyable?
    false
  end
end
