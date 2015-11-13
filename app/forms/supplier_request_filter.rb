class SupplierRequestFilter
  include ActiveModel::Model
  attr_accessor :status, :name, :document_number

  def call(context=false)
    supplier_requests = context ? context.supplier_requests : SupplierRequest.all
    supplier_requests = supplier_requests.where(status: SupplierRequest.statuses[@status]) if @status.present?
    supplier_requests = supplier_requests.where('first_name like ? OR last_name like ?', "%#{@name}%", "%#{@name}%") if @name.present?
    supplier_requests = supplier_requests.where(document_number: @document_number) if @document_number.present?
    supplier_requests
  end
end