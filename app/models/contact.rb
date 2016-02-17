class Contact
    attr_reader :id, :name, :phone_number

    # Init with hash
    def initialize(args)  
        # Instance variables 
        args.each do |key, value|
            instance_variable_set("@#{key}", value) unless value.nil?
        end
    end

    # Override to_json to delete @ before variables
    def to_json
        hash = {}
        self.instance_variables.each do |var|
             hash[var.to_s.delete "@"] = self.instance_variable_get var
        end
        hash.to_json
    end

    def from_json! string
        JSON.load(string).each do |var, val|
            self.instance_variable_set var, val
        end
    end

    # Update the attributes if the instance from a hash
    def update_attributes(hash)
        hash.each do |key, value|
            m = "#{key}="
            self.send(m, value) if self.respond_to?(m)
        end
    end

    # Update the instance in the database with a hash
    def update(hash)
        Database.update @id, hash, self.class.table_name
        update_attributes hash
    end

    # Delete the instance from the database
    def delete
       Database.delete @id, self.class.table_name
    end

    # Class Methods

    # Should return the name of the table in the database. Subclass must override this!
    def self.table_name
        raise "You did not override table_name for class #{self.name}"
    end

    # Should return the sql code as a string to create the instance in the database. Subclass must override this!
    def self.create_sql(hash)
        raise "You did not override create_sql for class #{self.name}"
    end

    # Gets all rows for a instance.
    # name - The name to search for, otherwise nil to return all instances.
    def self.all(name = nil)
        if name.nil?
            Database.select_all self.table_name
        else
            Database.select_all self.table_name, name, 'name'
        end
    end

    # Get a specific instance from the database based on id 
    def self.find(id)
        hash = Database.select id, self.table_name
        if hash
            self.new hash
        end
    end

    # Creates a new instance in the database
    def self.create(hash)
        sql = self.create_sql hash
        Database.create sql
        row = Database.select_last table_name
        self.new row
    end
end