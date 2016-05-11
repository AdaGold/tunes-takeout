require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = ENV['YELP_CONSUMER_KEY']
  config.consumer_secret = ENV['YELP_CONSUMER_KEY']
  config.token = ENV['YELP_TOKEN_KEY']
  config.token_secret = ENV['YELP_TOKEN_KEY']
end
