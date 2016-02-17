require_relative 'contact'

class Client < Contact
	attr_reader :id, :name, :phone_number, :project_name, :budget

	# Overrides
	
	def self.table_name
		'Client'
	end

	def self.create_sql(hash)
		"INSERT INTO Client(name,phone_number,project_name,budget) VALUES('#{hash["name"]}','#{hash["phone_number"]}','#{hash["project_name"]}',#{hash["budget"]})"
	end
end
