class Suggestion < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :spotify_item
end
