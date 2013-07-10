module PrestaShop
	class URLResolver
		attr_accessor :options
		attr_accessor :query_params
		attr_accessor :configuration

		def initialize(configuration, user_options)
			@configuration = configuration
			@options = user_options

			query_options = options.except :method,
										   :payload,
										   :resource,
										   :id 
			unless configuration.default_shop?
				query_options[:id_shop] = configuration.shop_id
			end

			@query_params = QueryParams.new query_options
		end

		def validate!
			query_params.validate!
		end

		def to_s
			url = "#{configuration.api_url}"
			if options[:resource]
				url << options[:resource]
				if options[:id]
					url << "/#{options[:id]}"
				end
			end

			
			url << "?" if options[:query] or options[:payload]
			
			if options[:payload]
				url << "xml='#{CGI.escape(options[:payload])}'"
				url << "&" if options[:query]
			end

			if options[:query]
				url << options[:query]
			end

			url
		end
	end
end