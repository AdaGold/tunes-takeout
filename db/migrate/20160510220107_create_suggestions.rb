class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.references :restaurant, index: true, foreign_key: true, null: false
      t.references :spotify_item, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
