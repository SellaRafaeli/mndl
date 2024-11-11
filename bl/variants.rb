$variants = $mongo.collection('variants')

get '/variants/delete/:_id' do 
  require_user 
  require_admin

  $variants.delete_one({_id: pr[:_id]})
  flash.message = 'Variant deleted.' 

  redirect back
end


post '/variant' do 
  require_user

  proj_id = pr[:project_id] 
  gene_id = pr[:gene_id]
  data    = {dna: pr[:dna], project_id: proj_id, gene_id: gene_id, host: pr[:host]}

  $variants.add(data)

  flash.message = 'Variant added'
  redirect '/projects/'+proj_id
end