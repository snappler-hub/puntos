# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  type       :string(255)      not null
#  card_id    :integer
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServicePfpc < Service
  
  # -- Associations
  has_many :product_pfpcs, foreign_key: :service_id, dependent: :destroy
  has_many :products, through: :product_pfpcs
  accepts_nested_attributes_for :product_pfpcs, reject_if: :all_blank, allow_destroy: true
  
  # -- Methods
  def self.model_name
    superclass.model_name
  end
  
end
