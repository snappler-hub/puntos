# == Schema Information
#
# Table name: reward_order_items
#
#  id              :integer          not null, primary key
#  reward_order_id :integer
#  reward_id       :integer
#  amount          :integer
#  need_points     :float(24)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RewardOrderItem < ActiveRecord::Base

  include ActsAsStockEntry


  belongs_to :reward_order
  belongs_to :reward


  def change_stock
		params = {owner: self, amount: amount, codename: 'canjeo_premio', date: DateTime.now}
		reward.stock_hard_down(params) if reward.present?
  end

  def rollback_change_stock
  	params = {owner: self, amount: amount, codename: 'cancelado_premio', date: DateTime.now}
		reward.stock_hard_up(params) if reward.present?
  end

  def total_need_points
    need_points * amount
  end
end
