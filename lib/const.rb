class Const
  # Códigos para autorización de venta
  STATUS_ERROR = 'ERROR'
  STATUS_OK = 'OK'
  STATUS_WARNING = 'ADVERTENCIA'
  
  AUTHORIZATION_EXPIRATION_LIMIT = 120 # En minutos
  
  # URL PARA ENVIO DE MAILS

  URL = Rails.env.development? ? 'localhost:3000' : '159.203.127.247:88'
end