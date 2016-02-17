class Database
	@db = SQLite3::Database.new 'development.db'

	def self.db 
		@db
	end

	def self.selectAll(table)
		@db.execute "SELECT * FROM #{table}"
	end

	def self.select(id, table)
		begin
			row = db.get_first_row "SELECT * FROM #{table} WHERE id = ?", id 
			return row
		rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.selectFirst(table)
		select 1, table
	end

	def self.selectLast(table)
		begin
			row = db.get_first_row "SELECT * FROM #{table} ORDER BY id DESC LIMIT 1"
			return row
		rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.update(id, property, value, table)
		begin
	    	@db.execute "UPDATE #{table} SET #{property} = ? WHERE id = ?", value, id
	    rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end
end