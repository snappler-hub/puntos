class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :supplier_request
  # Atributos: 
  # - number 
  # - terms_accepted
  enum status: {unprinted: 0, printed: 1}


  def generate_number
    hashids = Hashids.new("this is my salt", 16, "ABCDEF1234567890")
    hashids.encode(id)
  end

end