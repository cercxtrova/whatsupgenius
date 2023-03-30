class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :phone
      t.text :last_request
      t.string :spotify_user_id
      t.string :spotify_user_token
      t.string :spotify_user_refresh_token
      t.string :spotify_playlist_id

      t.timestamps
    end
  end
end
