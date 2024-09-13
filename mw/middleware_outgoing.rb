after do 
  if @response.body.is_a? Hash #return hashes as json
    content_type 'application/json'
    @response.body = @response.body.to_json   
  end 
end

get '/mw/outgoing' do 'refresh' end