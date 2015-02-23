json.array!(@movies) do |movie|
  json.extract! movie, :id, :id, :name, :image_url, :genders
  json.url movie_url(movie, format: :json)
end
