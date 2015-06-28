json.array!(@books) do |book|
  json.extract! book, :id, :name, :token
  json.url book_url(book, format: :json)
end
