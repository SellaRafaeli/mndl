$variants = $mongo.collection('variants')

get '/variants/delete/:_id' do 
  require_user 
  require_admin

  $variants.delete_one({_id: pr[:_id]})
  flash.message = 'Variant deleted.' 

  redirect back
end