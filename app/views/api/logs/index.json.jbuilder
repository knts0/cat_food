json.set! :logs do
  json.array! @logs do |log|
    puts log.fed_at
    fed_formatted = log.fed_at.in_time_zone('Tokyo').strftime("%H:%M")
    json.extract! log, :id, :cat_id, :feed_id, :created_at, :updated_at
    json.fed_at fed_formatted
  end
end
