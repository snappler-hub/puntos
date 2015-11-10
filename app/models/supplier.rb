class Supplier < ActiveRecord::Base

  include Destroyable

  has_many :users

  def destroyable?
    true #TODO: only if has no users.
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

end