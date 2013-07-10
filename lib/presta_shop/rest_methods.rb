module PrestaShop
	class RestMethods
		attr_accessor :head, :get, :post, :put, :delete

		alias_method :head?,   :head
		alias_method :get?,    :get
		alias_method :post?,   :post
		alias_method :put?,    :put
		alias_method :delete?, :delete

		def initialize(attributes)
			if attributes.nil? or attributes.empty?
				@head = false
				@get  = false
				@post = false
				@put  = false
				@delete = false
			else
				rest_attributes.each do |name, attr|
					self.send "#{name}=", attr.value
				end
			end
		end

		def supported?(method)
			self.send method
		end
	end
end