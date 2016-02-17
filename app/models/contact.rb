class Contact
    def initialize(id, name, phone_number)  
        # Instance variables 
        @id = id 
        @name = name  
        @phone_number = phone_number
    end

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

    def update_attributes(hash)
        hash.each do |key, value|
            m = "#{key}="
            self.send(m, value) if self.respond_to?(m)
        end
    end
end