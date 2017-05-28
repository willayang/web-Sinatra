require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'

class Comment
  include DataMapper::Resource
  def self.default_repository_name
     :comments
  end
  property :id, Serial
  property :name, String
  property :title, String
  property :created_at, DateTime
  property :body, Text
  #property :type, Discriminator
end
 DataMapper.finalize 
get '/comments' do
   @comment = Comment.all
   erb :comments
end 

get '/comments/new' do
   @comment = Comment.new
   erb :new_comment
end

get '/comments/:id' do
   @comment = Comment.get(params[:id])
   erb :show_comment
end

post '/comments' do
 comment = Comment.create(params[:comment])
 redirect to ("/comments/#{comment.id}")
end

put 'comments/:id' do#not sure if necessary!!
  comment = Comment.get(params[:id])
  student.update(params[:comment])
  redirect to ("/comments/#{comment.id}")
end



