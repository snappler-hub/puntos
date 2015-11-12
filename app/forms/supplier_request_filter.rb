class SupplierRequestFilter
  include ActiveModel::Model
  attr_accessor :status, :email

  def call(context=false)
    supplier_requests = context ? context.supplier_requests : SupplierRequest.all
    supplier_requests = supplier_requests.where(status: SupplierRequest.statuses[@status]) if @status.present?
    supplier_requests = supplier_requests.where(email: @email) if @email.present?
    supplier_requests
  end
end