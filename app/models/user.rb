require 'pry'

class User < ActiveRecord::Base
  # Remember to create a migration!
  def make_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_secret
    end
    return client
  end
end
