$projects = $mongo.collection('projects')

PROJ_STATUS_DRAFT     = 'draft' 
PROJ_STATUS_SUBMITTED = 'submitted' 

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
  data[:status]  = PROJ_STATUS_DRAFT
  proj = $projects.add(data)

  flash.message = "Created project."
  redirect '/projects/'+proj[:_id]
end

post '/project/:_id/submit' do 
  require_user

  proj = $projects.get(pr[:_id])
  halt unless proj[:user_id] == cuid
  
  $projects.update_id(pr[:_id],{status: PROJ_STATUS_SUBMITTED})

  flash.message = "Project submitted."
  redirect back
end