module PrestaShop
	class Configuration
		attr_accessor :api_url, :api_key
		attr_accessor :shop_id
		attr_accessor :debug, :log
		attr_accessor :headers
		
		alias_method :debug?, :debug
		
		def initialize
			@api_url = nil
			@api_key = nil
			@shop_id = nil
			@debug   = false
			@log     = 'stdout'
			@headers = {}
		end

		def api_url=(url)
			return if url.nil?
			return unless url.valid_url?

			@api_url = url
			unless @api_url.end_with? "/"
				@api_url << "/"
			end

			unless @api_url.end_with? "/api/"
				@api_url << "/api/"
			end
		end

		def api_key=(user_api_key)
			return if user_api_key.nil? or user_api_key.empty?
			@api_key = user_api_key
		end

		def headers=(user_headers)
			@headers = user_headers
			unless @headers.has_key? "User-Agent"
				@headers["User-Agent"] = "PrestaShop Ruby Library v#{PrestaShop::VERSION}"
			end
		end

		def log=(user_log)
			if user_log == :stderr or user_log == :stdout
				user_log = user_log.to_s
			end

			if user_log.kind_of?(::String)
				@log = user_log
				RestClient.log = @log
			end
		end

		def default_shop?
			@shop_id.nil?
		end

		def validate!
			raise UninitializedError unless @api_url and @api_key
		end
	end
end