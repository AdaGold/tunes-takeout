class AddimagestoUser < ActiveRecord::Migration
  def change
    add_column :users, :images, :string    # for the unique user identifier from the provider
  end
end
