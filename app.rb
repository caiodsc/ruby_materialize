require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require 'facebook/messenger'
require './config/database'
require_relative './config.rb'
require_relative './encrypt_decrypt.rb'
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ACCESS_TOKEN)

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base

  #set :root, "./app"
  set :views, "./app/views"
  set :public_folder, "./app/public"
  #set :static_cache_control, [:public]

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
        "platform": "facebook",
        "speech": response,
        "type": 0
    }
    .to_json
  end

  get '/teste' do
    #retorna
    @treta = @params[:id].decrypt
    erb :teste, :layout => :z_index
  end

  get '/contracheque' do

  end

  get '/minhaavaliacao' do

  end

  get '/certificado' do

  end

  get '/desconto' do

  end

  get '/bancohora' do

  end
end
