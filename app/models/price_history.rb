class PriceHistory < ActiveRecord::Base
  belongs_to :product
  belongs_to :alfabeta_update
end