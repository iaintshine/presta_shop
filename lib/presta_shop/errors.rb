module PrestaShop
	class WebServiceError < RuntimeError
	end

	class UninitializedError < WebServiceError
		def initialize
			super "PrestaShop gem not initialized. Please configure first." 
		end
	end

	class UnsupportedParamsError < WebServiceError
		def initialize
			super "Unsupported query parameters."
		end
	end

	class UnsupportedVersion < WebServiceError
		def initialize
			super "Unsupported PrestaShop web service version."
		end
	end

	class UnknownResource < WebServiceError
		def initialize
			super "Unknown PrestaShop web service resource."
		end
	end

	class InvalidRequest < WebServiceError
		def initialize
			super "Invalid http request."
		end
	end
end