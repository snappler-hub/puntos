# == Schema Information
#
# Table name: products
#
#  id                         :integer          not null, primary key
#  code                       :string(255)      not null
#  name                       :string(255)      not null
#  points                     :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  barcode                    :string(255)
#  presentation_form          :string(255)
#  price                      :float(24)
#  expiration_date            :date
#  controlled_product_mark    :integer
#  imported                   :boolean
#  sell_type                  :integer
#  registration_numer         :integer
#  deleted                    :boolean          default(FALSE)
#  units                      :integer          default(1)
#  size                       :integer
#  sifar                      :boolean
#  potency                    :string(255)
#  troquel_number             :string(255)
#  relative_presentation_size :integer
#  administration_route_id    :integer
#  drug_id                    :integer
#  pharmacologic_form_id      :integer
#  potency_unit_id            :integer
#  unit_type_id               :integer
#  parmacologic_scope_id      :integer
#  pharmacologic_scope_id     :integer
#  laboratory_id              :integer
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
