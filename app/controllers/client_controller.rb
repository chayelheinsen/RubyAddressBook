class ClientController < ApplicationController
	# list all
	get '/', :provides => :json do
		if params.has_key? 'name'
			Client.all(params['name']).to_json
		else
			Client.all.to_json
		end
	end

	# view one
	get '/:id', :provides => :json do
		client = Client.find params[:id]
		return status 404 if client.nil?
		client.to_json
	end

	# create
	post '/', :provides => :json do
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		client = Client.create request_payload["client"]
		client.to_json
	end

	# update
	put '/:id', :provides => :json do
		client = Client.find params[:id]
		return status 404 if client.nil?
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		client.update request_payload["client"]
		client.to_json
	end

	patch '/:id', :provides => :json do
		client = Client.find params[:id]
		return status 404 if client.nil?
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		client.update request_payload["client"]
		client.to_json
	end

	# delete
	delete '/:id', :provides => :json do
		client = Client.find params[:id]
		return status 404 if client.nil?
		client.delete
		status 202
	end
end