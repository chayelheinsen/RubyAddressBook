class Database
	@@db = SQLite3::Database.new 'development.db'

	def self.db 
		@@db
	end

	def self.select_all(table, search = nil, property = nil)
		if search.nil?	
			@@db.execute "SELECT * FROM #{table}"
		else
			@@db.execute "SELECT * FROM #{table} WHERE #{property} LIKE ?", search
		end
	end

	def self.select(id, table)
		begin
			row = @@db.get_first_row "SELECT * FROM #{table} WHERE id = ?", id 
			return row
		rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.select_first(table)
		select 1, table
	end

	def self.select_last(table)
		begin
			row = @@db.get_first_row "SELECT * FROM #{table} ORDER BY id DESC LIMIT 1"
			return row
		rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.update_single(id, property, value, table)
		begin
	    	@@db.execute "UPDATE #{table} SET #{property} = ? WHERE id = ?", value, id
	    rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.update(id, hash, table)
		begin
			@@db.transaction do |db|
				hash.each do |key, value|
					db.execute "UPDATE #{table} SET #{key} = ? WHERE id = ?", value, id
				end
			end
	    rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.delete(id, table)
		begin
	    	@@db.execute "DELETE FROM #{table} WHERE id = ?", id
	    rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end
end