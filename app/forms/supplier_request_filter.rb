class SupplierRequestFilter
  include ActiveModel::Model
  attr_accessor :status, :name, :document_number, :supplier_id, :user

  def call(context=false, user)
    supplier_requests = context ? context.supplier_requests : SupplierRequest.all
    supplier_requests = supplier_requests.where(status: SupplierRequest.statuses[@status]) if @status.present?
    supplier_requests = supplier_requests.where('first_name like ? OR last_name like ?', "%#{@name}%", "%#{@name}%") if @name.present?
    supplier_requests = supplier_requests.where(document_number: @document_number) if @document_number.present?
    # @supplier_id |= user.supplier_id unless user.is?(:god)
    # supplier_requests = supplier_requests.where(supplier_id: @supplier_id) if @supplier_id.present?
    supplier_requests
  end
end