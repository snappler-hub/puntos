# == Schema Information
#
# Table name: products
#
#  id                         :integer          not null, primary key
#  code                       :string(255)      not null
#  barcode                    :string(255)
#  troquel_number             :string(255)
#  name                       :string(255)      not null
#  presentation_form          :string(255)
#  price                      :float(24)
#  expiration_date            :date
#  imported                   :boolean
#  sell_type                  :integer
#  registration_number        :integer
#  units                      :integer          default(1)
#  size                       :integer
#  potency                    :string(255)
#  relative_presentation_size :integer
#  client_points              :float(24)        default(0.0)
#  seller_points              :float(24)        default(0.0)
#  pharmacologic_action_id    :integer
#  drug_id                    :integer
#  pharmacologic_form_id      :integer
#  potency_unit_id            :integer
#  unit_type_id               :integer
#  administration_route_id    :integer
#  laboratory_id              :integer
#  deleted                    :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
