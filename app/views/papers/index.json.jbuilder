json.array!(@papers) do |paper|
  json.extract! paper, :id, :title
  json.url paper_url(paper, format: :json)
end
