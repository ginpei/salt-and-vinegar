json.array!(@items) do |item|
  json.extract! item, :id, :paper_id, :name, :quantity, :orderer
  json.url item_url(item, format: :json)
end
