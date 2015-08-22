json.array!(@listings) do |listing|
  json.extract! listing, :id, :description
  json.url listing_url(listing, format: :json)
end
