json.set! :log do
  json.extract! @log, :id, :cat_id, :feed_id, :fed_at, :created_at, :updated_at
end
