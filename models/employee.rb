require_relative '../helpers/database'
require_relative 'contact'

class Employee
	def initialize(name, phone_number, title)  
	    # Instance variables  
	    @name = name  
	    @phone_number = phone_number  
	    @title = title
  	end

	def self.createTable
		Database.db.execute "CREATE TABLE IF NOT EXISTS Employee(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, phone_number STRING, title STRING)"
	end

	def self.tableName
		createTable
		'Employee'
	end

	def self.all
		Database.selectAll tableName
	end

	def self.find(id)
		Database.select id, tableName
	end

	def self.create(hash)
		employee = Employee.new hash["name"], hash["phone_number"], hash["title"]
		Database.db.execute "INSERT INTO Employee(name,phone_number,project_name,budget) VALUES(?,?,?,?)", hash["name"], hash["phone_number"], hash["project_name"], hash["budget"]
		employee
	end
end