require 'dm-core'
require 'dm-migrations'
#student firstname, lastname, birthday, address, student id, and other properties you like.



class Student
  attr_reader :firstname
  include DataMapper::Resource
  def self.default_repository_name
     :students
  end
  property :id, Serial
  property :idshow, Integer
  property :firstname, String
  property :lastname, String
  property :fullname, Text
  property :address, Text
  property :birthday, Date
  #property :type, Discriminator
  
  def birthday=date
    super Date.strptime(date, '%m/%d/%Y')
  end
=begin
  def initialize (firstname)
     @firstname = firstname.empty? ? "NoName" : firstname
  end
=end
end

DataMapper.finalize

get '/students' do
  @students = Student.all
  erb :students
end

get '/students/new' do
  #halt(401, 'NOT Authorized') unless session[:admin]
  if session[:admin] != true#need to login
     redirect to('/login')
  else 
   @student = Student.new
   erb :new_student
  end
end

get '/students/:id' do
  @student = Student.get(params[:id])
  erb :show_student
end

get '/students/:id/edit' do
  if session[ :admin] != true
     redirect to('/login')
  #halt(401, 'NOT Authorized,Please login ') unless session[:admin]
  else
    @student = Student.get(params[:id])
    erb :edit_student 
  end

end

post '/students' do  
  student = Student.create(params[:student])
  redirect to("/students/#{student.id}")
end

put '/students/:id' do
  student = Student.get(params[:id])
  student.update(params[:student])
  redirect to("/students/#{student.id}")
end

delete '/students/:id' do
  Student.get(params[:id]).destroy
  redirect to('/students')
end

