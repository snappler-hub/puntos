class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :supplier_request
  # Atributos: 
  # - number 
  # - terms_accepted
end