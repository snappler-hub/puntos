module SpecificHelper

  def icon_ok
    icon(:check, class: 'text-success')
  end

  def icon_not_ok
    icon(:close, class: 'text-danger')
  end

  def comment_widget(url)
    content_tag :div, '', class: 'comments_widget', data: { path: url } 
  end

end