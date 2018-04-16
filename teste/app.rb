require 'sinatra'
require_relative 'sinatra_ssl'

set :ssl_certificate, "#{File.dirname(__FILE__)}/server.pem"
set :ssl_key, "#{File.dirname(__FILE__)}/bemolcombr.key"
set :port, 8443
set :server, :puma

#class Application < Sinatra::Base

  get '/teste' do
    "helloworld"
  end

#end