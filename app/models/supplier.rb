# == Schema Information
#
# Table name: suppliers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Supplier < ActiveRecord::Base

  include Destroyable

  has_many :users
  has_many :supplier_requests
  has_many :supplier_vademecums
  has_many :vademecums, through: :supplier_vademecums

  validates :name, presence: true

  def destroyable?
    users.empty?
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

end