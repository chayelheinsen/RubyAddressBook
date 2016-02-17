require_relative 'contact'

class Client < Contact
	def initialize(id, name, phone_number, project_name, budget)  
	    # Instance variables  
	    super id, name, phone_number
	    @project_name = project_name
	    @budget = budget
  	end

	def self.table_name
		'Client'
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
			Client.new obj[0], obj[1], obj[2], obj[3], obj[4]
		end
	end

	def self.create(hash)
		Database.db.execute "INSERT INTO Client(name,phone_number,project_name,budget) VALUES(?,?,?,?)", hash["name"], hash["phone_number"], hash["project_name"], hash["budget"]
		obj = Database.select_last table_name
		Client.new obj[0], obj[1], obj[2], obj[3], obj[4]
	end

	def update(hash)
		Database.update @id, hash, Client.table_name
		update_attributes hash
	end

	def delete
		Database.delete @id, Client.table_name
	end
end
