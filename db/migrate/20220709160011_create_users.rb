class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :google_user_id, null: false
      t.string :access_token
      t.string :refresh_token
      t.timestamps
    end
  end
end
