module ApplicationHelper

  def flash_message(klass, message)
    #klass = 'success' if klass == 'notice'
    #klass = 'danger'  if klass == 'alert'
    flash.discard(klass)
    content_tag :span, '', class: 'snackbar-message',
      data: {toggle: :snackbar, content: message, timeout: 10000}
  end

  def flash_messages
    capture do
      flash.each do |type, message|
        concat flash_message(type, message)
      end
    end
  end

  def close_button(target = :modal)
    link_to '&times;'.html_safe, '', class: :close, data: {dismiss: target}
  end

  def icon(name, html_options={})
    html_options[:class] = ['fa', "fa-#{name}", html_options[:class]].compact
    content_tag(:i, nil, html_options)
  end
  
  # Link del menú lateral
  def side_link(link_text, link_path, icon_class='', klass='', html_options={}, extra='')
    link_class = html_options[:class]
    html_options[:class] = link_class
    klass += current_page?(link_path) ? 'active' : url_for(link_path)
    content_tag(:li, class: klass) do
      (link_to link_path, html_options do
        "<i class='fa fa-fw fa-#{icon_class}'></i> <span> #{link_text} </span>".html_safe
      end) +
      extra.html_safe
    end
  end

  def permitted_roles
    god? ? User::ROLES : User::ROLES - ['god']
  end

  def god?
    logged_in? && current_user.role == 'god'
  end

  def supplier?
    logged_in? && current_user.role == 'admin' && current_user.supplier_id
  end

  def seller?
    logged_in? && current_user.role == 'seller' && current_user.supplier_id
  end
  
  def admin?
    logged_in? && current_user.role == 'admin' && current_user.supplier_id
  end
  
  def normal_user?
    logged_in? && current_user.role == 'normal_user'
  end    

  def is_me?(user)
    logged_in? && current_user == user
  end

  def current_user_name
    "#{current_user.first_name} #{current_user.last_name}"
  end
  
  # Mapa editable
  def build_map(id='map', options={})
    options[:width] ||= '100%' 
    options[:height] ||= '275px' 
    options[:position] = (options[:latitude].blank?) ? 'current' : 'defined'
    options[:latitude] = (options[:latitude].blank?) ? '' : options[:latitude]
    options[:longitude] = (options[:longitude].blank?) ? '' : options[:longitude]
    raw "<div id='#{id}' style='width: #{options[:width]}; height: #{options[:height]};' 
        class='js-map' data-position='#{options[:position]}' data-latitude='#{options[:latitude]}'
           data-longitude='#{options[:longitude]}'></div>"
  end

  # Imagen de un mapa con un marcador puesto
  def map_image(lat, long, width=500, height=400)
    "http://maps.google.com/maps/api/staticmap?zoom=16&size=#{width}x#{height}&markers=#{lat},#{long}&sensor=false"
  end

  def reward_order_state(reward_order)
    actions = reward_order.get_state_actions
    actions.collect{|x| link_to t(x, scope: :reward_order_states), change_state_reward_order_path(reward_order, state: x), remote: true, class: "btn btn-xs #{(['canceled','not_delivered'].include?(x))? 'btn-danger' : 'btn-success'}" }.join().html_safe
  end

end