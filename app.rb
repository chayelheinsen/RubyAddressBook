require 'sinatra'
require 'sqlite3'
require_relative 'models/client'
require_relative 'models/employee'

# Clients

# list all
get '/clients', :provides => :json do
	Client.all.to_json
end

# view one
get '/clients/:id', :provides => :json do
	client = Client.find params[:id]
	return status 404 if client.nil?
	client.to_json
end

# create
post '/clients', :provides => :json do
	request.body.rewind
  	request_payload = JSON.parse request.body.read
	client = Client.create request_payload["client"]
	client.to_json
	#status 201
end

# update
put '/clients/:id', :provides => :json do
	client = Client.find params[:id]
	return status 404 if client.nil?
	client.update params["client"]
	status 202
end

# delete
delete '/clients/:id', :provides => :json do
	client = Client.find params[:id]
	return status 404 if client.nil?
	client.delete
	status 202
end