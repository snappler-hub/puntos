class Supplier < ActiveRecord::Base

  include Destroyable

  has_many :users
  has_many :supplier_requests

  validates :name, presence: true

  def destroyable?
    users.empty?
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

end