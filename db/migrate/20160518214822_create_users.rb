class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :uid, null:false       # for the unique user identifier from the provider
      t.string :provider, null:false    # for the provider name
      t.string :name
      t.string :email
      t.timestamps null: false
    end
  end
end
