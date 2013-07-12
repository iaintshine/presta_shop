require 'uri'

String.class_eval do 
	def valid_url?
		uri = URI.parse self
		uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
	rescue => e 
		false
	end

	def to_boolean
		return true if self =~ (/\A(true|t|yes|y|1)\Z/i)
		return false if self.empty? or self =~ (/\A(false|f|no|n|0)\Z/i)
		raise ArgumentError.new("Invalid value for Boolean: \"#{self}\"")
	end
end