module ApplicationHelper

  def flash_message(klass, message)
    klass = 'success' if klass == 'notice'
    klass = 'danger'  if klass == 'alert'
    flash.discard(klass)
    content_tag :article, class: "alert alert-#{klass}" do
      concat close_button(:alert)
      concat message
    end
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

  def icon_ok
    icon(:check, class: 'text-success')
  end

  def icon_not_ok
    icon(:close, class: 'text-danger')
  end

  def god?
    logged_in? && current_user.role == 'god'
  end

  def supplier?
    logged_in? && current_user.role == 'admin' && current_user.supplier_id
  end

  def is_me?(user)
    logged_in? && current_user == user
  end

  def current_user_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

end