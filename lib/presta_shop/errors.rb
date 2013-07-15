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
		def initialize(version)
			super "Unsupported PrestaShop web service version : #{version}."
		end
	end

	class UnknownResource < WebServiceError
		def initialize(resource)
			super "Unknown PrestaShop web service resource : #{resource}."
		end
	end
end