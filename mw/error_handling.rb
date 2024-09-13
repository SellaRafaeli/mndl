$errors = $mongo.collection('errors')

module Helpers
  def log_e(err, data = {})  
    err = {msg: err.to_s, backtrace: err.backtrace.to_a.slice(0,20)} if err.is_a? Exception
    err = {msg: err} unless err.is_a? Hash    
    $errors.add(err)
  rescue => e
    puts e
  end
end

error do 
  e = env['sinatra.error']    
  log_e(e)
  data = {msg: "an error occurred", e: e.to_s, backtrace: e.backtrace.to_a.slice(0,20).to_s}
  if $prod  
    flash.message = 'Oops! Something went wrong.'
    redirect '/'
  end
  data
end

not_found do
  return {err: 'Not found (no such route/resource)'}
end
