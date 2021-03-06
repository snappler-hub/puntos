# == Schema Information
#
# Table name: supplier_point_products
#
#  id          :integer          not null, primary key
#  supplier_id :integer
#  product_id  :integer
#  points      :float(24)        default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SupplierPointProduct < ActiveRecord::Base

  # Associations
  belongs_to :supplier
  belongs_to :product
  
  validates :supplier, presence: true

end
