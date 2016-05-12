class RenameTypeOnSpotifyItem < ActiveRecord::Migration
  def change
    rename_column :spotify_items, :type, :item_type
  end
end
