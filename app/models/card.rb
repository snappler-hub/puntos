# == Schema Information
#
# Table name: cards
#
#  id                  :integer          not null, primary key
#  number              :string(255)
#  user_id             :integer
#  terms_accepted      :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  supplier_request_id :integer
#

class Card < ActiveRecord::Base
  
  # -- Associations
  belongs_to :user
  belongs_to :supplier_request
  has_many :services
  
  # Atributos: 
  # - number 
  # - terms_accepted

  def generate_number
    hashids = Hashids.new("this is my salt", 16, "ABCDEF1234567890")
    hashids.encode(id)
  end

end
