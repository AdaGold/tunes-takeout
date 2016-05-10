class CreateSpotifyItems < ActiveRecord::Migration
  def change
    create_table :spotify_items do |t|
      t.string :item_id
      t.string :type
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps null: false
    end
  end
end
