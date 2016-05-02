class RewardFilter
  include ActiveModel::Model
  attr_accessor :name, :code, :need_points, :reward_kind, :only_availables

  def call
    rewards = Reward.all
    rewards = rewards.joins(:stocks).where('stocks.real_stock_in_int >= 100') if @only_availables.present?
    rewards = rewards.where('name LIKE ?', "%#{@name}%") if @name.present?
    rewards = rewards.where('code LIKE ?', "%#{@code}%") if @code.present?
    rewards = rewards.where('need_points <= ?', @need_points) if @need_points.present?
    rewards = rewards.where('reward_kind LIKE ?', "%#{@reward_kind}%") if @reward_kind.present?
    rewards
  end
end