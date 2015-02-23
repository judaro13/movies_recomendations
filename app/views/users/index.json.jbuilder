json.array!(@users) do |user|
  json.extract! user, :id, :id, :name, :image_url, :handle
  json.url user_url(user, format: :json)
end
