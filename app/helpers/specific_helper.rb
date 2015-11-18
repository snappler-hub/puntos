module SpecificHelper

  def icon_ok
    icon(:check, class: 'text-success')
  end

  def icon_not_ok
    icon(:close, class: 'text-danger')
  end

  # Muestra más lindo el número de tarjeta.
  # Permite definir separador.
  # Por defecto transforma "1234567890123456" en "1234 5678 9012 3456"
  def format_card_number(number, separator: ' ')
    number.scan(/.{1,4}/).join(separator)
  end

  def comment_widget(url)
    content_tag :div, '', class: 'comments_widget', data: { path: url } 
  end

end