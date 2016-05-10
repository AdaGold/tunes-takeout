# Tunes and Takeout
This is a Rails project designed for students to gain experience building websites that make use of 3rd-party *web services* through *web APIs*.

The major requirement for this project is to integrate both the Yelp Search API and the Spotify API, combining the two into a website that suggests pairings of food and music.


## Technical Details
### Resources
#### Restaurant
Restaurants represent particular businesses retrieved from the Yelp Search API. They have the following attributes:

| attribute | data type | description |
| --------- | ---------:| ----------- |
| __business_id__ | string | Yelp-specific ID, which can be used to make calls to the Yelp Business API to retrieve complete details |
| __name__ | string | Name of the business |
| __url__ | string | Yelp URL for this business |
| __image_url__ | string | URL of the photo to display for this business |
| __phone__ | string | Phone number for the business |
| __rating__ | decimal number | Average rating for this business based on Yelp reviews |

#### Spotify Item
Spotify Items are specific resources from the Spotify API including: artists, albums, tracks, and playlists. They have the following attributes:

| attribute | data type | description |
| --------- | ---------:| ----------- |
| __item_id__ | string | Spotify-specific ID, which can be used in conjunction with the type to make calls to the Spotify API |
| __type__ | string | Which type of resource this item is. Can be: artist, album, track, playlist |
| __name__ | string | Name of the item |
| __url__ | string | URL for opening this item in a browser-based Spotify player |
| __image_url__ | string | URL of the photo to display for this item |

#### Suggestion
Suggestions are pairs of one Restaurant and one SpotifyItem. They are what this website is all about, suggestions on how to combine music and food. Because the pairings are random, we rely upon crowdsourced ratings from our users to determine if a particular pairing is good.
