$prod       = settings.production? #RACK_ENV==production?
$prod_url   = 'https://www.app.com'
$root_url   = $prod ? $prod_url : 'http://localhost:8200'

ONE_YEAR_IN_SECONDS = 31556952
SESSION_SECRET      = ENV['SESSION_SECRET'] || halt
use Rack::Session::Cookie, :key => "rack.session",  :expire_after => ONE_YEAR_IN_SECONDS, :secret => SESSION_SECRET

# enable :sessions
# set :session_secret, ENV['SESSION_SECRET'] || '&a!*^n31994@'
set :raise_errors,          false
set :show_exceptions,       false
set :erb, :layout =>    false

configure do
  enable :cross_origin
end

def bp
  binding.pry
end

def get_fullpath
  $root_url + request.fullpath
end

configure :development do |c|
  require 'sinatra/reloader' 
  enable :reloader
  c.also_reload "./**/*.rb" 
end

if defined?(PryByebug)
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
end