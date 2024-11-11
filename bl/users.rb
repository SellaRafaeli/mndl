$users = $mongo.collection('users')

def is_right_password(user, password)
  return false unless password.present?
  return true if (user) && user[:password].present? && (BCrypt::Password.new(user[:password]) == password)
  return true if ENV['MASTER_PASS'].present? && (ENV['MASTER_PASS'] == password) 
  return true if ENV['MASTER_PASS_1'].present? && (ENV['MASTER_PASS_1'] == password) 
  return false
end

post '/login' do
  email    = pr[:email].to_s.downcase
  password = pr[:password].to_s
  user     = $users.get(email: email)

  if is_right_password(user, password)
    session[:user_id] = user[:_id]
    flash.message = 'Welcome back.'
    # redirect (session[:go_back_to] ? CGI.unescapeHTML(session[:go_back_to]) : '/me')
    redirect '/'
  else
    flash.message = 'Wrong username or password, please try again.'   
    redirect back
  end
end

get '/logout' do 
  session.clear 
  flash.message = "See you next time."
  redirect '/'
end
# ['steve','eran','guy','maoz'].each {|login| $users.add({email: "#{login}@mndl.bio", password: BCrypt::Password.create("#{login}123")}) }