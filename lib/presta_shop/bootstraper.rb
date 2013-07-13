# More OO way - wrap in class

module PrestaShop
	def self.bootstrap!
		configuration.validate!

		query_permissions
	end

	def self.query_permissions
		response = nil 
		begin
			response = RestClient::Request.new( :method => :get, 
												:url => configuration.api_url,
												:user => configuration.api_key,
												:headers => configuration.headers).execute 
		rescue RestClient::Unauthorized
			raise Unauthorized
		rescue 
			raise InvalidRequest
		end 

		Headers.new(response).validate!

		xml_doc = Nokogiri::XML(response) do |config|
			config.noblanks
		end

		# Any additional validation?
		return if xml_doc.root.children.empty?

		# This one assumes only first shop is taken under consideration
		first_shop = xml_doc.root.chidlren.first

		return if first_shop.children.empty?

		first_shop.children.each do |n|
			# this requires rails
			attributes = n.attributes.except("href").map { |k, v| v.to_boolean }
			 
			permissions[n.name.to_sym] = RestMethods.new attributes
		end
	end
end