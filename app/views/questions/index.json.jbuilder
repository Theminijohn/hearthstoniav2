json.array!(@questions) do |question|
  json.extract! question, :title, :body
  json.url question_url(question, format: :json)
end
