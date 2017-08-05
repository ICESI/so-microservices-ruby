require 'rubygems'
require 'sinatra'
#require "sinatra/multi_route"  # gem install sinatra-contrib
require 'json'

#use Rack::Logger

configure do
  class << Sinatra::Base
    def options(path, opts={}, &block)
      route 'OPTIONS', path, opts, &block
    end
  end
  Sinatra::Delegator.delegate :options
end

students = Array.new
students.push(
  {
  :identification => "1111",
  :fullName=> "Daniel Barragan",
  :email => "daniel.barragan@gmail.com",
  }
)
students.push(
  {
  :identification => "2222",
  :fullName => "Juan Alvarez",
  :email => "juan.alvarez@gmail.com",
  }
)
students.push(
  {
  :identification => "3333",
  :fullName => "Daniel Adolfo",
  :email => "daniel.adolfo@gmail.com",
  }
)
#id = 3


before do
   content_type :json    
   headers 'Access-Control-Allow-Origin' => '*', 
	   'Access-Control-Allow-Methods' => ['GET', 'POST', 'PUT', 'DELETE','OPTIONS'],
	   'Access-Control-Allow-Headers' => 'Content-Type' #,X-Requested-With,Accept',
     #'Access-Control-Allow-Credentials'=> 'true'
     #'Access-Control-Max-Age => 86400'
end

#set :protection, false

=begin
options '/classassist/api/v1.0/students','/classassist/api/v1.0/students/*' do
  200
end
=end

options '/classassist/api/v1.0/students' do
  200
end

options '/classassist/api/v1.0/students/*' do
  200
end

post '/classassist/api/v1.0/students' do
  
  data = JSON.parse request.body.read
  identification = data['identification']
  fullName = data['fullName']
  email = data['email']

  index = students.index{|student| student[:identification] == identification}
  if index == nil
    new_student = {:identification => identification,:fullName=> fullName,:email => email}
    students.push(new_student)
    [{:method => "POST", :status => "done",:message => "User inserted"}].to_json
  else
    [{:method => "POST", :status => "fail",:message => "User already exist"}].to_json
  end
end

get '/classassist/api/v1.0/students' do
  students.to_json
end

#['cat','dog','horse'].select{ |x| x == 'dog' }.any?
#tasks[0][:title]
get '/classassist/api/v1.0/students/:identification' do
   identification = params['identification'] #.to_i

   index = students.index{|student| student[:identification] == identification}
   if index != nil
     student = students.find{|student| student[:identification] == identification}
     [student].to_json 
   else
     [{:identification => "", :fullName => "",:email => ""}].to_json
   end
end

# students.insert(3,{:id=>"",:identification=>"",:fullName=>"",:email=>""})
put '/classassist/api/v1.0/students/:identification' do
   identification = params['identification']

   data = JSON.parse request.body.read
   #identification = data['identification'] # es el mismo identificador que llega en la url
   fullName = data['fullName']
   email = data['email']

   index = students.index{|student| student[:identification] == identification}
   if index != nil
     students[index][:fullName] = fullName
     students[index][:email] = email
     [{:method => "PUT", :status => "done",:message => "User updated"}].to_json
   else
     [{:method => "PUT", :status => "fail",:message => "User does not exist"}].to_json
   end
end

delete '/classassist/api/v1.0/students/:identification' do
  identification = params['identification']
  index = students.index{|student| student[:identification] == identification}
  if index != nil
    students.delete_at(index)
    [{:method => "DELETE", :status => "done",:message => "User deleted"}].to_json
  else
    [{:method => "DELETE", :status => "fail",:message => "User does not exist"}].to_json
  end
end

error 404 do
  erb :index
end

