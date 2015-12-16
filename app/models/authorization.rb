# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  client_id  :integer
#  products   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)
#  message    :text(65535)
#  points     :integer          default(0)
#

class Authorization < ActiveRecord::Base

  serialize :products, Array

  # -- Scopes
  default_scope -> { order('created_at DESC') }

  # -- Associations
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'

  # -- Validations
  # validates :seller, presence: true
  # validates :client, presence: true

  # -- Methods
  def total
    products.reduce(0) { |sum, product| sum + product[:total] }
  end

  def without_error?
    status == Const::STATUS_OK || status == Const::STATUS_WARNING
  end
end
