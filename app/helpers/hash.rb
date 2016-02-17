class Hash

	# Removes keys that are digits
	def remove_digit_keys!
		self.delete_if do |key, value| 
			key.to_s.match(/\d/)
		end
	end
end