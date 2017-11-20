require 'json'
require 'sinatra'
require 'rest-client'
require 'sinatra/basic_auth'
require 'sinatra/activerecord'
require './config/database'
require_relative './config.rb'
require_relative './encrypt_decrypt.rb'

# Configurando a gem facebook-messenger
require 'facebook/messenger'
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ACCESS_TOKEN)

# Importando os diretórios
Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base
  # Basic Auth for protect routes.
  register Sinatra::BasicAuth
  authorize do |username, password|
    username == USER_AUTH && password == PASSWORD_AUTH
  end

  # Helpers Declaration
  #helpers Sinatra::App::ApplicationHelper

  # Specifying views and stylesheet directories
  set :views, "./app/views"
  set :public_folder, "./app/public"

  # Routes
  get '/' do
    redirect url + 'info'
  end

  protect do
    get '/info' do
      #html :info
      erb :info
    end
  end

  post '/webhook' do
    result = JSON.parse(request.body.read)["result"]
    if result["contexts"].present?
      response = InterpretService.call(result["contexts"][-2]["name"], result["action"], result["contexts"][-2]["parameters"], result["contexts"][-1]["parameters"]["facebook_sender_id"])
    else
      response = InterpretService.call(result["name"], result["action"], result["parameters"], result["parameters"]["facebook_sender_id"])
    end
    #response = result.to_s
    content_type :json
    response
  end

  get '/teste' do
    #retorna
    @treta = @params[:id].decrypt
    erb :teste, :layout => :z_index
  end

  get '/contracheque' do
    erb :contracheque, :layout => :z_index
  end

  get '/minhaavaliacao' do
    erb :minhaavaliacao, :layout => :z_index
  end

  get '/certificado' do
    erb :certificado, :layout => :z_index
  end

  get '/desconto' do
    erb :desconto, :layout => :z_index
  end

  get '/bancohora' do
    erb :bancohora, :layout => :z_index
  end

end


#set :static_cache_control, [:public]
#set :root, "./app"
#response = result.to_s
#content_type :json
#{
#    "speech": response,
#    "displayText": response,
#    "source": "OneBitBot"
#}.to_json
#def html(view)
#  File.read(File.join('app/views', "#{view.to_s}.html"))
#end