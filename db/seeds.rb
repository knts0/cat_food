3.times { Task.create!(name: 'Sample Task') }
2.times { Task.create!(name: 'Sample Task', is_done: true) }

Log.create!(cat_id: 1, feed_id: 1, fed_at: Time.zone.local(2018, 9, 9, 15, 00, 00))
Log.create!(cat_id: 1, feed_id: 1, fed_at: Time.zone.local(2018, 9, 9, 18, 00, 00))
