class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :calendar, null: false, foreign_key: true
      t.string :google_id
      t.text :attendees
      t.text :creator
      t.datetime :created
      t.text :description
      t.text :event_end
      t.text :event_start
      t.string :status
      t.string :summary

      t.timestamps
    end
  end
end
