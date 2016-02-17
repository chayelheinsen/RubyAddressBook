class Employee < Contact
	attr_reader :id, :name, :phone_number, :title

	# Overrides

	def self.table_name
		'Employee'
	end

	def self.create_sql(hash)
		"INSERT INTO Employee(name,phone_number,title) VALUES('#{hash["name"]}','#{hash["phone_number"]}','#{hash["title"]}')"
	end
end