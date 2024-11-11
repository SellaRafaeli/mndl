$projects = $mongo.collection('projects')

get '/projects' do 
  # flash.message = 'test'
  require_user 
  erb :'/projects/projects', default_layout
end

get '/projects/new' do 
  require_user

  erb :'/projects/new', default_layout
end

get '/projects/:_id' do 
  require_user 

  erb :'/projects/single_project', default_layout
end

get '/projects/:_id/add_variant' do 
  require_user 

  erb :'/projects/add_variant', default_layout
end

get '/projects/delete/:_id' do 
  require_user 
  require_admin

  $projects.delete_one({_id: pr[:_id]})
  flash.message = 'Project deleted.' 

  redirect '/projects'
end

post '/project' do 
  require_user
  data = pr.just(:name, :dna)

  data[:user_id] = cuid
  data[:status]  = :created
  proj = $projects.add(data)

  flash.message = "Created project."
  redirect '/projects/'+proj[:_id]
end