json.array!(@taxes) do |tax|
  json.extract! tax, :id, :rate, :name
  json.url tax_url(tax, format: :json)
end
