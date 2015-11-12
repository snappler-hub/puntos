json.array!(@supplier_requests) do |supplier_request|
  json.extract! supplier_request, :id, :firstname, :lastname, :identification_type, :identification_number, :phone, :email, :address, :notes
  json.url supplier_request_url(supplier_request, format: :json)
end
