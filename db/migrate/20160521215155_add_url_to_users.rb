class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :open_spotify_url, :string    # for the unique user identifier from the provider

  end
end
