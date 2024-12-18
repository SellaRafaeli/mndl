puts "starting app..."

require 'bundler'
require 'active_support'
require 'active_support/core_ext'
require 'sinatra/reloader' #dev-only

puts "requiring gems..."

Bundler.require

puts "loading dotenv..."
Dotenv.load

$app_name   = 'mndl'

require './setup'
require './my_lib'

require_all './db'
require_all './admin'
require_all './bl'
require_all './comm'
require_all './mw'

include Helpers #makes helpers globally available 

get '/ping' do
  {msg: "pong from #{$app_name}"}
end

get '/' do 
  if cu 
    redirect '/projects'
  else
    erb :'/login', default_layout  
  end
end

get '/dna_viewer' do 
  erb :'/genes/dna_viewer', default_layout
end