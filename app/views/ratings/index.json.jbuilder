json.array!(@ratings) do |rating|
  json.extract! rating, :id, :user_id, :movie_id, :value, :count
  json.url rating_url(rating, format: :json)
end
