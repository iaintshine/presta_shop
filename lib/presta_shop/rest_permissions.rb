module PrestaShop
	class RestPermissions
		attr_accessor :resources

		def initialize
			@resources = {}
		end

		def []=(resource, methods)
			resources[resource] = methods
		end

		def [](resource)
			resources[resource]
		end

		def any?
			not resources.empty?
		end

		def empty?
			resources.empty?
		end

		def respond_to?(method)
			resources.has_key? method
		end

		def method_missing(method_name, *args, &block)
			if respond_to? method_name
				resources[method_name]
			else
				super method_name, *args, &block
			end
		end
	end
end