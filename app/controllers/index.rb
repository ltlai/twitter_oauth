require 'twitter'

get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  # at this point in the code is where you'll need to create your user account and store the access token
  user = User.find_or_create_by_username_and_oauth_token_and_oauth_secret(
    @access_token.params[:screen_name], 
    @access_token.params[:oauth_token],
    @access_token.params[:oauth_token_secret])

  session[:id] = user.id

  erb :index
  
end

post '/tweet/' do
  user = User.find(session[:id])

  client = user.make_client

  client.update(params[:tweet_text])

  "Tweet submitted"
end