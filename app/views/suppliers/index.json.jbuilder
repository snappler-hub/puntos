json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :description, :active
  json.url supplier_url(supplier, format: :json)
end
