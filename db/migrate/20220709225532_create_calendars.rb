class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :google_id, null: false
      t.text :description
      t.string :summary
      t.boolean :primary

      t.timestamps
    end
  end
end
