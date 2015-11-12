class SupplierFilter
  include ActiveModel::Model
  attr_accessor :name, :state

  def call
    suppliers = Supplier.all
    suppliers = suppliers.where('name LIKE ?', "%#{@name}%") if @name.present?
    suppliers = suppliers.where(active: (@state == 'true'))  if @state.present?
    suppliers
  end
end