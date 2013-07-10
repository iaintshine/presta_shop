module PrestaShop
	def self.execute(options)
		# Check if url and query params are valid
		url = URLResolver.new configuration, options
		url.validate!

		# Make an request
		response = nil
		begin
			response = RestClient::Request.execute  :method   => options[:method], 
													:url 	  => url,
													:user 	  => configuration.api_key,
													:password => nil,
													:headers  => configuration.headers
		rescue => e
			raise IndalidRequest
		end

		# Validate if PrestaShop version is supported
		Headers.validate! response

		response
	end
end