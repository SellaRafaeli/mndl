def halt_missing_param(field)
  halt(403, {msg: "Missing field: #{field}"}) 
end

def require_fields(fields)
  Array(fields).each do |field| halt_missing_param(field) unless params[field].present? end 
end

def require_user
  halt(401,{err: 'Please log in first.'}) unless cu
end

get '/halts' do
  {msg: 'halt!'}
end