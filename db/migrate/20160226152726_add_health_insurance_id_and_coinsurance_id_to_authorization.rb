class AddHealthInsuranceIdAndCoinsuranceIdToAuthorization < ActiveRecord::Migration
  def change
    add_reference :authorizations, :health_insurance, index: true, foreign_key: true
    add_reference :authorizations, :coinsurance, index: true, foreign_key: true
  end
end
