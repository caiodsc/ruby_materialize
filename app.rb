require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base

  #set :root, "./app"
  set :views, "./app/views"

  get '/sinatra' do
    'Hello world Sinatra!'
  end

  post '/webhook' do
    result = JSON.parse(request.body.read)["result"]
    if result["contexts"].present?
      response = InterpretService.call(result["action"], result["contexts"][0]["parameters"], result["contexts"][-1]["parameters"]["facebook_sender_id"])
    else
      response = InterpretService.call(result["action"], result["parameters"], result["parameters"]["facebook_sender_id"])
    end
    #response += result.to_s
    content_type :json
    {
      "speech": response,
      "displayText": response,
      "source": "OneBitBot"
    }.to_json
  end

  get '/index' do
    @caio = "Oi"
    erb :index
  end
end
