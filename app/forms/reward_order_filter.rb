class RewardOrderFilter
  include ActiveModel::Model
  attr_accessor :state, :supplier_id, :user_id

  def call(user=nil)
    reward_orders = RewardOrder.all
    reward_orders = reward_orders.where(user_id: user.id) if user.present?
    reward_orders = reward_orders.where('supplier_id = ?', @supplier_id) if @supplier_id.present?
    reward_orders = reward_orders.where('user_id = ?', @user_id)         if @user_id.present?
    reward_orders = reward_orders.where('state = ?', @state)             if @state.present?
    reward_orders = reward_orders.order('id DESC')
    reward_orders
  end
end