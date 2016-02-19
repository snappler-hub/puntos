# == Schema Information
#
# Table name: reward_orders
#
#  id           :integer          not null, primary key
#  supplier_id  :integer
#  user_id      :integer
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  code         :string(255)
#  qr_code_uid  :string(255)
#  qr_code_name :string(255)
#

class RewardOrder < ActiveRecord::Base


  dragonfly_accessor :qr_code

  belongs_to :supplier
  belongs_to :user
  has_many :reward_order_items, dependent: :destroy


  validates :supplier_id, :user_id, presence: true
  after_create :generate_code

  REWARD_ORDER_STATES = %w(requested incoming ready delivered canceled not_delivered)


  def generate_code
    require 'rqrcode_png'
    hashids = Hashids.new('this is my salt', 16, 'ABCDEF1234567890')
    aux_code = hashids.encode(id)
    qr_code_img = RQRCode::QRCode.new(aux_code, size: 4, level: :h).to_img.resize(150, 150)
    aux_qr_code = qr_code_img.to_string
    update_attributes(code: aux_code, qr_code: aux_qr_code)
  end


  def total_amount
    total = 0
    reward_order_items.each { |x| total += x.amount }
    total
  end

  def total_need_points
    total = 0
    reward_order_items.each { |x| total += x.total_need_points }
    total
  end


  def set_shop_cart(shop_cart)
    shop_cart.each do |x|
      reward = Reward.where('id = ?', x['item_id']).first
      self.reward_order_items << RewardOrderItem.new(reward_id: reward.id, amount: x['amount'], need_points: reward.need_points) unless (reward.nil?)
    end
    self
  end


  def get_state_actions
    case state
      when 'requested'
        %w(incoming canceled)
      when 'incoming'
        %w(ready not_delivered)
      when 'ready'
        %w(delivered not_delivered)
      when 'canceled'
        %w(requested)
      else
        []
      #when 'delivered'
      #when 'not_delivered'
    end
  end

  def send_mail
    case state
      when 'requested'
        subject = 'Tu pedido ha sido ingresado!'
        title = "El pedido ##{self.code} se ha realizado exitosamente. "
      when 'incoming'
        subject = 'Tu pedido está en camino!'
        title = "El pedido ##{self.code} ya está en camino. "
      when 'delivered'
        subject = 'Tu pedido está listo para retirar!'
        title = "El pedido ##{self.code} ya está disponible para ser retirado. "
      else
        subject = 0
    end
    unless subject == 0
      message = 'Para verlo, haga clic en el siguiente enlace. '
      url = Const::URL+'/reward_orders/'+self.id.to_s
      UserMailer.new_mail(self.user, title, message, subject, url)
    end
  end

  def change_state(state)
    case state
      when 'requested'
        update(state: 'requested')
        reward_order_items.each(&:change_stock)
        self.user.decrease_points(self.total_need_points)
      when 'incoming'
        update(state: 'incoming')
      when 'ready'
        update(state: 'ready')
      when 'delivered'
        update(state: 'delivered')
      when 'canceled'
        update(state: 'canceled')
        reward_order_items.each(&:rollback_change_stock)
      when 'not_delivered'
        update(state: 'not_delivered')
    end
  end

  #Saber q estado esta
  %w(requested incoming ready delivered canceled not_delivered).each do |name|
    define_method("#{name}?".to_sym) do
      state == "#{name}"
    end
  end

end
