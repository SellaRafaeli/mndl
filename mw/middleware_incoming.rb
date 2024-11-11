require 'rack/protection'

use Rack::Parser, :content_types => {
  'application/json'  => Proc.new { |body| ::MultiJson.decode body }
}

if $prod
  use Rack::SslEnforcer
end

use Rack::Protection

before do
  @time_started_request = Time.now    
end

def pr
  return @params if @params 
  @params = params rescue {}
end

def request_header(name)
  request.env['HTTP_'+name.upcase.to_s]
end

def cu_token
  token = request_header(:token) || params[:token]
  user  = $users.get(token: token) if token
  user
end

def cu_session
  session && session[:user_id] && $users.get(session[:user_id]) rescue nil #for tux
end

def cu
  if request.path_info.starts_with?("/admin")
    res = (@cu ||= cu_session)
  else
    res = (@cu ||= (cu_token || cu_session || nil))
  end
  
  @cu = res
  res 
end

def cuid # current user id  
  cu && cu['_id']
end

def _req 
  request rescue OpenStruct.new #call 'request' safely, including from tux 
end

def is_admin 
  cu && cu[:email] == 'sella.rafaeli@gmail.com'
end

get '/mw/middleware_incoming' do 'refresh this' end