class EmployeeController < ApplicationController
	# list all
	get '/', :provides => :json do
		if params.has_key? 'name'
			Employee.all(params['name']).to_json
		else
			Employee.all.to_json
		end
	end

	# view one
	get '/:id', :provides => :json do
		employee = Employee.find params[:id]
		return status 404 if employee.nil?
		employee.to_json
	end

	# create
	post '/', :provides => :json do
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		employee = Employee.create request_payload["employee"]
		employee.to_json
	end

	# update
	put '/:id', :provides => :json do
		employee = Employee.find params[:id]
		return status 404 if employee.nil?
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		employee.update request_payload["employee"]
		employee.to_json
	end

	patch '/:id', :provides => :json do
		employee = Employee.find params[:id]
		return status 404 if employee.nil?
		request.body.rewind
	  	request_payload = JSON.parse request.body.read
		employee.update request_payload["employee"]
		employee.to_json
	end

	# delete
	delete '/:id', :provides => :json do
		employee = Employee.find params[:id]
		return status 404 if employee.nil?
		employee.delete
		status 202
	end
end