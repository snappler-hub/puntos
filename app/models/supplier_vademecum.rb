# == Schema Information
#
# Table name: supplier_vademecums
#
#  id           :integer          not null, primary key
#  supplier_id  :integer
#  vademecum_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class SupplierVademecum < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :vademecum
end
