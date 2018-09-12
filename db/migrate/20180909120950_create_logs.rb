class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :cat_id
      t.integer :feed_id
      t.datetime :fed_at

      t.timestamps
    end
  end
end
