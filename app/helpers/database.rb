class Database
	# The database to use
	@@db = SQLite3::Database.new 'development.db'
	# We want results to come back as a hash instead of an array
	@@db.results_as_hash = true

	# The db
	def self.db
		@@db
	end

	# Returns all ros for a given table
	# table - The name of the table
	# search - The string to search for.
	# property - The column name.
	def self.select_all(table, search = nil, property = nil)
		arr = nil

		if search.nil?
			arr = @@db.execute "SELECT * FROM #{table}"
		else
			arr = @@db.execute "SELECT * FROM #{table} WHERE #{property} LIKE ?", search
		end

		arr.each do |row|
			Database.remove_digit_keys! row
			#row.remove_digit_keys!
		end
	end

	def self.select(id, table)
		begin
			row = @@db.get_first_row "SELECT * FROM #{table} WHERE id = ?", id
			Database.remove_digit_keys! row
			#row.delete_digit_keys!
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
			Database.remove_digit_keys! row
			#row.delete_digit_keys!
			return row
		rescue SQLite3::Exception => e
			puts "Exception occurred"
    		puts e
		end
	end

	def self.create(sql)
		begin
	    	@@db.execute sql
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

	private

	def self.remove_digit_keys!(row)
		if row
			row.delete_if do |key, value| 
			key.to_s.match(/\d/)
			end
		end
	end
end