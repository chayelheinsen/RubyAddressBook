require_relative '../helpers/database'
require_relative 'contact'

class Client < Contact
	def initialize(id, name, phone_number, project_name, budget)  
	    # Instance variables  
	    super id, name, phone_number
	    @project_name = project_name
	    @budget = budget
  	end

	def self.createTable
		Database.db.execute "CREATE TABLE IF NOT EXISTS Client(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, phone_number STRING, project_name STRING, budget INTEGER)"
	end

	def self.tableName
		createTable
		'Client'
	end

	def self.all
		Database.selectAll tableName
	end

	def self.find(id)
		obj = Database.select id, tableName
		if obj
			Client.new obj[0], obj[1], obj[2], obj[3], obj[4]
		end
	end

	def self.create(hash)
		Database.db.execute "INSERT INTO Client(name,phone_number,project_name,budget) VALUES(?,?,?,?)", hash["name"], hash["phone_number"], hash["project_name"], hash["budget"]
		obj = Database.selectLast tableName
		Client.new obj[0], obj[1], obj[2], obj[3], obj[4]
	end

	def update(hash)
		hash.each do |key, value|
			Database.update self.id, key, value, Client.tableName
		end
		Client.find self.id
	end
end
