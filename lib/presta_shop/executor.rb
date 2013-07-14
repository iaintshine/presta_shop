module PrestaShop
	def self.execute(options)
		# Check if url and query params are valid
		url = URLResolver.new configuration, options
		url.validate!

		# Make an request
		response = nil
		begin
			response = RestClient::Request.execute  :method   => options[:method], 
													:url 	  => url.to_s,
													:user 	  => configuration.api_key,
													:headers  => configuration.headers
		rescue RestClient::Unauthorized
			raise Unauthorized
		rescue 
			raise InvalidRequest
		end

		# Validate if PrestaShop version is supported
		Headers.new(response).validate!

		response
	end
end