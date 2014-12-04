require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do 
    @title = "Kyle Jones's Portfolio" 
    @description = "This site showcases all of the awesome things that Kye Jones has done."
    @home = "active"
    erb :home 
end

get '/about' do
    @title = "About Me"
    @description = "This page provides a short bio for Kyle Jones."
    @about = "active"
    erb :about
end

get '/works' do 
    @title = "My Clips"
    @description = "This page provides links to Kyle Jones public sites."
    @works = "active"
    erb :works
end

get '/tweets' do 
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "KiTNpI4rqUWeuh0KR9CB32lyV"
        config.consumer_secret     = "emN6pNQlSqN7WfP7xaWBhNGSh2tGBv7Ugi9XN7JCWKg22CUNGX"
        config.access_token        = "51299621-Rpoj1F586SXNLQrDYgEagdbDSib2tJIewdkr6rzS6"
        config.access_token_secret = "2EOto7unip5Ebot0bCGPqzZFw2lLUMQLGcd92HZikGNcX"
end
   
    @search_results = client.search("@nfl" "@ESPNNFL", result_type: "recent").take(50).collect do |tweet|
      #"#{tweet.user.screen_name}: #{tweet.text}"
        tweet 
end
    
    @title = "NFL NEWS TWEETS"
    @description = "This page is all about NFL news tweets"
    @works = "active"
    erb :tweets
end 

get '/instanfl' do 
    require 'instagram'
    @title = "NFL on Istagram"
    @description = "This page gives the latest NFL News via pictures."
    @works = "active" 

        Instagram.configure do |config|
            config.client_id = "2b80af3b9cf04b57882cda32b7528a26"
            config.client_secret = "50d3e08902f344daba71dd5d6dad0fb2"
            #For secured endpoints only
        end

        client = Instagram.client(:access_token => session[:access_token])
        tags = client.tag_search ('nflonespn' 'nfl')
            @photos = Array.new
        for media_item in client.tag_recent_media(tags[0].name)
            #html << "<img src='#{media_item.images.thumbnail.url}'>"
            @photos.push(media_item)
        end
    erb :instanfl
end 