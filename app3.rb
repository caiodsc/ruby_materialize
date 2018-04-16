require 'sinatra'

class App < Sinatra::Base

  get '/teste' do
    "hello"
  end

end