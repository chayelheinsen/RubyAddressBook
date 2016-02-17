class Employee < Contact
	def initialize(id, name, phone_number, title)  
	    # Instance variables  
	    super id, name, phone_number
	    @title = title
  	end

	def self.table_name
		'Employee'
	end

	def self.all(name = nil)
		if name.nil?
			Database.select_all table_name
		else
			Database.select_all table_name, name, 'name'
		end
	end

	def self.find(id)
		obj = Database.select id, table_name
		if obj
			Employee.new obj[0], obj[1], obj[2], obj[3]
		end
	end

	def self.create(hash)
		Database.db.execute "INSERT INTO Employee(name,phone_number,title) VALUES(?,?,?)", hash["name"], hash["phone_number"], hash["title"]
		obj = Database.select_last table_name
		Employee.new obj[0], obj[1], obj[2], obj[3]
	end

	def update(hash)
		Database.update @id, hash, Employee.table_name
		update_attributes hash
	end

	def delete
		Database.delete @id, Employee.table_name
	end
end