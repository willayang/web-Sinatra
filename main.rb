require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'
require './student'
require './comment'
require 'sass'
enable :sessions
configure do
  enable :sessions
  set :username, 'frank'#login name
  set :password, 'sinatra'#login passwords
end
configure :development do
  DataMapper.setup(:students, "sqlite3://#{Dir.pwd}/development.db")#?
  DataMapper.setup(:comments, "sqlite3://#{Dir.pwd}/comments.db")#?
end
configure :production do
  DataMapper.setup(:students, ENV['DATABASE_URL'])
  DataMapper.setup(:comments, ENV['DATABASE_URL'])
end

get('/style.css'){scss :styles}

get'/' do
  erb :home
end


get '/video' do
   erb :video
end
get '/contact' do
   erb :contact
end

get '/about' do
  erb :about
end

get '/login' do
   erb :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to ('/students')
  else
    erb :login
  end
end

get '/logout' do
   session.clear
   redirect to('/login')
end
 
not_found do
  erb :not_found
end
