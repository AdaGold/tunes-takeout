class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :oauth_provider
      t.string :oauth_uid
      t.string :spotify_data

      t.timestamps null: false
    end
  end
end
