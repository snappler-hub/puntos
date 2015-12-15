# == Schema Information
#
# Table name: rewards
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  description   :text(65535)
#  code          :string(255)      not null
#  need_points   :integer
#  reward_kind   :string(255)      not null
#  image_uid     :string(255)
#  image_name    :string(255)
#  service_types :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reward < ActiveRecord::Base

  include ActsAsStock
  include ActsAsStockEntry
  
	dragonfly_accessor :image
  serialize :service_types, Array
  REWARD_KINDS = %w(workshop product other)

  # -- Scopes
  default_scope { order(:code) }
  
  # -- Validations
  validates :name, :image, :code, :need_points, :reward_kind, presence: true
  validates :name, :code, uniqueness: true

  def to_s
    name
  end

  def stock_entries_arqueo_negativo
    stock_entries.where(codename: 'arqueo_negativo')
  end

  def stock_entries_arqueo_positivo
    stock_entries.where(codename: 'arqueo_positivo')
  end

end


