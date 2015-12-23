class RewardOrderFilter
  include ActiveModel::Model
  attr_accessor :state, :supplier_id, :user_id, :code, :from, :to

  def call(user=nil)
    reward_orders = RewardOrder.all
    if user.present?
      if user.role == 'admin' || user.role == 'seller'
        reward_orders = reward_orders.where(supplier_id: user.supplier_id)
      elsif user.role == 'normal_user'
        reward_orders = reward_orders.where(user_id: user.id)
      end
    end


    reward_orders = reward_orders.where('code = ?', @code)               if @code.present?
    reward_orders = reward_orders.where('supplier_id = ?', @supplier_id) if @supplier_id.present?
    reward_orders = reward_orders.where('user_id = ?', @user_id)         if @user_id.present?
    reward_orders = reward_orders.where('state = ?', @state)             if @state.present?
    reward_orders = reward_orders.where('created_at >= ?', @from)             if @from.present?
    reward_orders = reward_orders.where('created_at <= ?', @to)             if @to.present?
    reward_orders = reward_orders.order('id DESC')
    reward_orders
  end

  def user
    if @user_id.present?
      User.find(@user_id)
    end
  end

  def user_name
    user.to_s if user.present?
  end
end