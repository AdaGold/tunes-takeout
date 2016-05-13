# Tunes and Takeout
This is a Rails project designed for students to gain experience building websites that make use of 3rd-party *web services* through *web APIs*.

The major requirement for this project is to integrate both the Yelp Search API and the Spotify API, combining the two into a website that suggests pairings of food and music.

## Expectations
### General Requirements
* Unit tests for:
  * Controllers
  * Models
  * Routes
* Test code coverage (using SimpleCov)
  * 90% for all controller and model classes

### User Stories
#### Guest
As a guest to the website (not signed in) I **can**:

* Sign up / sign in with a Spotify account
* View the top favorited food+music pairing suggestions
  * Click on links for specific items to visit the appropriate page on Yelp or Spotify
  * See a relevant image for the venue or music

As a guest to the website (not signd in) I **cannot**:

* Search for food+music pairing suggestions
* Favorite individual food+music pairing suggestions

#### User
As a signed in user on the website I **can**:

* Do everything a guest user can do except for sign up / sign in
* Sign out
* See my Spotify account name and image on each page
  * Click on either to visit my Spotify user page
* Search for food+music pairing suggestions
* Favorite individual food+music pairing suggestions
* View my favorited food+music pairing suggestions
  * Unfavorite suggestions

As a signed in user on the website I **cannot**:

* View other users' favorited food+music pairing suggestions
* Favorite food+music pairing suggestions for other users
* Unfavorite food+music pairing suggestions for other users

### Deliverables
#### Models
##### User
A signed-in user account, with details that connect it to a specific Spotify account.

##### Suggestion
A pairing of a specific Food and Music recommendation, with API-specific reference info for each.

##### Favorite
A join model associating `Users` with `Suggestions`.

##### Food
A non-ActiveRecord model class holding data retrieved from Yelp API for a specific business.

##### Music
A non-ActiveRecord model class holding data retrieved from Spotify API for a specific artist/album/track/playlist.

#### Controllers
##### Sessions
* Actions
  * new - shows a view with OAuth sign-in link
  * create - accepts OAuth information from Spotify, finds or creates a User account, and sets `user_id` in session
  * destroy - deletes `user_id` from session

##### Suggestions
* Actions
  * index - shows top 20 suggestions, ranked by total number of favorites
  * favorites - shows all suggestions favorited by the signed-in User
  * favorite - adds a suggestion into the favorite list for the signed-in User
  * unfavorite - removes a suggestion from the favorite list for the signed-in User

#### Views
##### Layout
* On all pages, if not signed in:
  * Displays Guest and [default Spotify artist logo](https://profile-images.scdn.co/artists/default/b2108bd8af5cfb60872516b4c4417ac37d1737ae)
  * Displays link to sign-in page
* On all pages, if signed in:
  * Displays either my Spotify account name (`uid`), or real name (`name`), and my Spotify account's logo
  * Displays link to sign-out

##### Sessions
* sign_in
  * Displays Spotify logo prominently (see the [3rd-party developer design resoruces](https://developer.spotify.com/design/))
  * Displays a link to "Sign In With Spotify", which forwards to the Spotify OAuth API

##### Suggestions
* component (partial)
  * This is the HTML representation of a single suggestion
  * Displays a food recommendation on the left
    * Includes name of the business, linking to appropriate Yelp page
    * Includes address of the business (optional)
    * Includes phone number of the business (optional)
    * Includes photo/logo of the business
  * Displays a music recommendation on the left
    * Includes name of the music item, linking to appropriate Spotify page
    * Includes type of the music item
    * Includes photo/album cover of the music item
    * Includes embedded Spotify player if appropriate (optional)
* index
  * Displays component partials for the top 20 suggestions ranked by number of favorites
* favorites
  * Displays component partials for each suggestion favorited by the logged-in user
  * Each component partial also includes a button/link to unfavorite the suggestion

### Model Validations
#### User
* `provider` must be a string, must be present, and must equal `spotify`
* `uid` must be a string, and must be present
* `name`, if present, must be a string

#### Suggestion
* `food_id` must be a string, and must be present
* `music_id` must be a string, and must be present
* `music_type` must be a string, must be present, and must be one of: `artist`, `album`, `track`, or `playlist`
* Combination of above three attributes must be unique

#### Favorite
* `user_id` must be an integer, and must be present
* `suggestion_id` must be an integer, and must be present
* Combination of above two attributes must be unique

## Development Steps
### Wave 1 (OAuth)
* Establish Spotify app through [Spotify Developer Site](https://developer.spotify.com/)
* Integrate OmniAuth and RSpotify gems
* Integrate dotenv-rails gem
* Setup environment variables for OAuth secret & token
* Configure OmniAuth initializer with Spotify provider, using environment variables
* Create `User` model with `provider` and `uid` fields
* Write `find_or_create_by_auth_hash` method on `User` to support OAuth login
* Create `Sessions` controller with OAuth callback hook route
* Write `destroy` route for `Sessions` controller to support logout

### Wave 2 (API Client - Read)
* Integrate HTTParty gem
* Create API client module in `lib/` directory
* Create API client class as subclass of `HTTParty` class
* Configure client with API endpoint base (e.g. `https://tunes-takeout-api.herokuapp.com/v1/`)
* Write request method for `search` request
* Parse `search` request's response data as JSON, return the hash result
* Display `search` request's hash results directly in a view

### Wave 3 (API Mashup)
* Integrate Yelp gem
* Create non-AR models for `Restaurant` and `Album`
* Write methods for both models that build an instance from an API-specific ID
* Update view code to display model data instead of exact results from Tunes and Takeout API

### Wave 4 (API Client - Write)
* Write request method on API client for `favorite` request
* Provide Spotify user ID and Yelp business ID + Spotify album ID pair as parameters
* A


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
