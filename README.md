# Tunes and Takeout
This is a Rails project designed for students to gain experience building websites that make use of 3rd-party *web services- through *web APIs*.

The major requirement for this project is to integrate the __Yelp Search API__ and the __Spotify API__ into a single application that suggests pairings of food and music.

## Expectations
### General Requirements
- Unit tests for:
  - Models
  - API Wrappers
- Test code coverage (using SimpleCov)
  - 95% for all tested classes

### User Stories
#### Guest
##### As a guest to the website (not signed in) I _can_:

- Sign up / sign in with a __Spotify__ account
- View the top favorited food+music pairing suggestions
  - Click on links for specific items to visit the appropriate page on Yelp or Spotify
  - See a relevant image for the venue or music

##### As a guest to the website (not signd in) I _cannot_:

- Search for food+music pairing suggestions
- Favorite individual food+music pairing suggestions

#### User
##### As a signed in user on the website I _can_:

- Do everything a guest user can do except for sign up / sign in
- Sign out
- See my Spotify account name and image on each page
  - Click on either to visit my Spotify user profile
- Search for food+music pairing suggestions
- Favorite individual food+music pairing suggestions
- View my favorited food+music pairing suggestions
  - Unfavorite suggestions

##### As a signed in user on the website I _cannot_:

- Favorite food+music pairing suggestions for other users
- Unfavorite food+music pairing suggestions for other users

## Deliverables
### Models
- `User`: A signed-in user account, created via `OmniAuth` and connected to a Spotify account.
  - Validations:
    - `provider` must be a string, must be present, and must equal `spotify`
    - `uid` must be a string, and must be present
    - `name`, if present, must be a string

- `Food`: A plain Ruby object that receives and models data retrieved from the _Yelp Search API_. Wraps interactions with the _Yelp Search API_ by leveraging the [Yelp-Ruby gem](https://github.com/Yelp/yelp-ruby).
- `Music`: A plain Ruby object that receives and models data retrieved from the _Spotify API_. Wraps interactions with the _Spotify API_ by leveraging the [RSpotify gem](https://github.com/guilhermesad/rspotify). __NOTE:__ Data retrieved from Spotify may describe an artist, album, track, or playlist.

### API Wrappers:
- `TunesTakeoutWrapper`: Wraps interactions with the _Tunes & Takeout API_ by leveraging the [HTTParty gem](https://github.com/jnunemaker/httparty). Should reside in `lib/`.

### Controllers
#### Sessions
- Actions
  - `new`: shows a view with OAuth sign-in link
  - `create`: accepts OAuth information from Spotify, finds or creates a User account, and sets `user_id` in session
  - `destroy`: deletes `user_id` from session

#### Suggestions
- Actions
  - `index`: shows top 20 suggestions, ranked by total number of favorites
  - `favorites`: shows all suggestions favorited by the signed-in User
  - `favorite`: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the _Tunes & Takeout API_.
  - `unfavorite`: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the _Tunes & Takeout API_.

### Views
#### Layout
- On all pages, if not signed in:
  - Displays Guest and [default Spotify artist logo](https://profile-images.scdn.co/artists/default/b2108bd8af5cfb60872516b4c4417ac37d1737ae)
  - Displays link to sign-in page
- On all pages, if signed in:
  - Displays either my Spotify account name (`uid`), or real name (`name`), and my Spotify user avatar
  - Displays link to sign-out

#### Sessions
- `/sign_in`
  - Displays Spotify logo prominently (see the [3rd-party developer design resoruces](https://developer.spotify.com/design/))
  - Displays a link to "Sign In With Spotify", which forwards to the Spotify OAuth API

#### Suggestions
- `_suggestion` (partial)
  - This is the HTML representation of a single suggestion
  - Displays a food recommendation
    - Includes name of the business, linking to appropriate Yelp page
    - Includes address of the business (optional)
    - Includes phone number of the business (optional)
    - Includes photo/logo of the business
  - Displays a music recommendation
    - Includes name of the music item, linking to appropriate Spotify page
    - Includes type of the music item (artist, album, track, or playlist)
    - Includes photo/album cover of the music item
    - Includes embedded Spotify player if appropriate (optional)
- `index`
  - Displays `_suggestion` partials for the top 20 suggestions ranked by number of favorites
- `favorites`
  - Displays `_suggestion` partials for each suggestion favorited by the logged-in user
  - Each `_suggestion` partial also includes a button/link to unfavorite the suggestion

## Resource Details
### Restaurant
Restaurants represent particular businesses retrieved from the Yelp Search API. They have the following attributes:

| attribute | data type | description |
| --------- | ---------:| ----------- |
| __business_id__ | string | Yelp-specific ID, which can be used to make calls to the Yelp Business API to retrieve complete details |
| __name__ | string | Name of the business |
| __url__ | string | Yelp URL for this business |
| __image_url__ | string | URL of the photo to display for this business |
| __phone__ | string | Phone number for the business |
| __rating__ | decimal number | Average rating for this business based on Yelp reviews |

### Spotify Item
Spotify Items are specific resources from the Spotify API including: artists, albums, tracks, and playlists. They have the following attributes:

| attribute | data type | description |
| --------- | ---------:| ----------- |
| __item_id__ | string | Spotify-specific ID, which can be used in conjunction with the type to make calls to the Spotify API |
| __type__ | string | Which type of resource this item is. Can be: artist, album, track, playlist |
| __name__ | string | Name of the item |
| __url__ | string | URL for opening this item in a browser-based Spotify player |
| __image_url__ | string | URL of the photo to display for this item |

### Tunes & Takeout Suggestion
Suggestions are pairs of one Restaurant and one SpotifyItem. They are what this website is all about, suggestions on how to combine music and food. Because the pairings are random, we rely upon crowdsourced ratings from our users to determine if a particular pairing is good.

[See the Tunes & Takeout API documentation](https://github.com/AdaGold/tunes-takeout-api)
