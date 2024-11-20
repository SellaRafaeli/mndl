$genes = $mongo.collection('genes')

get '/genes/:proj_id/add_gene' do 
  require_user 

  erb :'/genes/new', default_layout
end

post '/gene' do 
  require_user

  data = pr 

  data[:region_preserve_start] = data[:region_preserve_start].to_a.select {|v| v.present? }
  data[:region_preserve_end]   = data[:region_preserve_end].to_a.select {|v| v.present? }

  data[:regions_to_preserve] =  data[:region_preserve_start].to_a.zip(data[:region_preserve_end].to_a).map { |a, b| "#{a}-#{b}" } 

  data[:user_id] = cuid

  $genes.add(data)

  flash.message = 'Gene added.'
  redirect '/projects/'+pr[:project_id]  
end

get '/genes/delete/:_id' do 
  require_user 
  require_admin

  $genes.delete_one({_id: pr[:_id]})
  flash.message = 'Gene deleted.' 

  redirect back
end