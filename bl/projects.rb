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

post '/project' do 
  require_user
  data = pr.just(:name, :dna)

  data[:user_id] = cuid
  data[:status]  = :created
  $projects.add(data)

  flash.message = "Created project."
  redirect '/projects'
end